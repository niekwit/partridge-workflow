rule press_model:
    input:
        hmm="resources/iap.hmm",
    output:
        expand("resources/iap.hmm.{ext}", ext=["h3f", "h3i", "h3m", "h3p"]),
    log:
        "logs/press_model.log",
    conda:
        "../envs/partridge.yaml"
    shell:
        "hmmpress {input.hmm} > {log} 2>&1"


rule extract_insertions:
    input:
        bam="results/mapped/{sample}.bam",
        hmm=expand("resources/iap.hmm.{ext}", ext=["h3f", "h3i", "h3m", "h3p"]),
    output:
        tsv="results/insertions/{sample}.isa.tsv",
    params:
        outdir= lambda wc, output: os.path.dirname(output["tsv"]),
        hmm=lambda wc, input: os.path.splitext(input["hmm"][0])[0],
        chunk_size=config["hmmer2_args"]["chunk_size"],
    log:
        "logs/partridge/extract_insertions/{sample}.log",
    threads: 6
    conda:
        "../envs/partridge.yaml"
    shell:
        "python workflow/scripts/PARTRIDGE/partridge/isa_hmmer2.py "
        "--threads {threads} "
        "--bam {input.bam} "
        "--hmm {params.hmm} "
        "--outdir {params.outdir} > {log} 2>&1"


rule collect_insertions:
    input:
        tsv=expand("results/insertions/{sample}.isa.tsv", sample=SAMPLES),
        metadata="config/metadata.xlsx",
    output:
        somatic_pdf="results/insertions/somatic.pdf",
        germline_pdf="results/insertions/germline.pdf",
        table="results/insertions/aggregated_insertions_table.xlsx",
        audit="results/insertions/manual_review_audit_table.xlsx",
    params:
        extra=""
    log:
        "logs/partridge/collect_insertions.log",
    conda:
        "../envs/partridge.yaml"
    shell:
        "Rscript workflow/scripts/PARTRIDGE/scripts/collect_insertions.R "
        "--tsv {input.tsv} "
        "--metadata {input.metadata} "
        "--germline-pdf {output.germline_pdf} "
        "--somatic-pdf {output.somatic_pdf} "
        "--output-xlsx {output.table} "
        "--audit-xlsx {output.audit} > {log} 2>&1 && "
        "[ -f {output.germline_pdf} ] || touch {output.germline_pdf}"