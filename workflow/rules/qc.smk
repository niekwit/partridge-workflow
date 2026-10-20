# Downloads the UCSC rmsk table (goldenPath database dump -- the same table
# hgTables serves under Track: RepeatMasker) and converts it to a plain BED
# file (chrom, start, end, repName, ., strand, repClass, repFamily) with only
# the ERVK family (rmsk column 13), which includes the IAP elements. The "chr"
# prefix is stripped (chrM -> MT) and only standard chromosomes are kept, to
# match the Ensembl-style contigs of the BAM files.
rule prepare_ervk_bed:
    output:
        genome_resources.ervk_bed,
    params:
        url=genome_resources.repeat_mask_url,
    log:
        "logs/prepare_ervk_bed.log",
    conda:
        "../envs/get_genome.yaml"
    threads: 1
    shell:
        "wget -q {params.url} -O {output}.gz 2> {log} ;"
        "zcat {output}.gz | "
        "awk -F'\\t' -v OFS='\\t' "
        '\'{{sub(/^chr/, "", $6); if ($6 == "M") $6 = "MT"; '
        "if ($6 !~ /^([0-9]+|X|Y|MT)$/) next; "
        'if ($13 != "ERVK") next; '
        'print $6, $7, $8, $11, ".", $10, $12, $13}}\' '
        "> {output} 2>> {log} ;"
        "rm -f {output}.gz"


# Fraction of all reads that are non-clipped, low-mismatch hits on a known
# ERVK element, as a measure of capture enrichment. The script processes
# every *.bam in --bam-dir and writes a fully-matched fragment coverage
# bigWig next to each BAM.
rule ervk_enrichment_qc:
    input:
        bams=expand("results/mapped/{sample}.bam", sample=SAMPLES),
        bed=genome_resources.ervk_bed,
    output:
        csv="results/qc/ervk_enrichment_qc.csv",
        plot="results/qc/ervk_enrichment_qc.pdf",
        bw=expand("results/mapped/{sample}.fully_matched.bw", sample=SAMPLES),
    params:
        bam_dir=lambda wc, input: os.path.dirname(input["bams"][0]),
        max_mismatches=config["ervk_qc"]["max_mismatches"],
    log:
        "logs/ervk_enrichment_qc.log",
    threads: 4
    conda:
        "../envs/ervk_qc.yaml"
    shell:
        "python workflow/scripts/PARTRIDGE/partridge/ervk_enrichment_qc.py "
        "--bam-dir {params.bam_dir} "
        "--bed {input.bed} "
        "--max-mismatches {params.max_mismatches} "
        "--threads {threads} "
        "--output-csv {output.csv} "
        "--output-plot {output.plot} > {log} 2>&1"
