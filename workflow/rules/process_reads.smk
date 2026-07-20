# fetch genome sequence from Ensembl
# -----------------------------------------------------
rule get_genome:
    output:
        fasta=genome_resources.fasta,
    log:
        "logs/get_genome.log",
    conda:
        "../envs/get_genome.yaml"
    params:
        url=genome_resources.fasta_url,
    shell:
        "wget -O {output.fasta}.gz {params.url} > {log} 2>&1 && "
        "gunzip {output.fasta}.gz >> {log} 2>&1"


rule bwa_mem2_index:
    input:
        genome_resources.fasta,
    output:
        "resources/{genome}.0123",
        "resources/{genome}.amb",
        "resources/{genome}.ann",
        "resources/{genome}.bwt.2bit.64",
        "resources/{genome}.pac",
    threads: 12
    log:
        "logs/bwa-mem2_index/{genome}.log",
    wrapper:
        "v7.2.0/bio/bwa-mem2/index"


rule trim_galore_pe:
    input:
        ["reads/{sample}_R1_001.fastq.gz", "reads/{sample}_R2_001.fastq.gz"],
    output:
        fasta_fwd="results/trimmed/{sample}_R1.fastq.gz",
        report_fwd="results/trimmed/reports/{sample}_R1_trimming_report.txt",
        fasta_rev="results/trimmed/{sample}_R2.fastq.gz",
        report_rev="results/trimmed/reports/{sample}_R2_trimming_report.txt",
    log:
        "logs/trim_galore/{sample}.log",
    threads: 6
    params:
        extra=config["trim_galore_args"],
    conda:
        "../envs/trim_galore.yml"
    wrapper:
        "v9.9.0/bio/trim_galore/pe"


rule bwa_mem2_mem:
    input:
        reads=[
            "results/trimmed/{sample}_R1.fastq.gz",
            "results/trimmed/{sample}_R2.fastq.gz",
        ],
        # Index needs to be a list of all index files created by bwa
        idx=expand(
            "resources/{genome}.fasta.{ext}",
            genome=GENOME,
            ext=["amb", "ann", "bwt.2bit.64", "pac", "0123"]
        ),
    output:
        "results/mapped/{sample}.bam",
    log:
        "logs/bwa_mem2/{sample}.log",
    threads: 12
    params:
        extra=r"-R '@RG\tID:{sample}\tSM:{sample}'",
        sort="samtools",  # Can be 'none', 'samtools', or 'picard'.
        sort_order="coordinate",  # Can be 'coordinate' (default) or 'queryname'.
        sort_extra="",  # Extra args for samtools/picard sorts.
    wrapper:
        "v9.4.1/bio/bwa-mem2/mem"


rule samtools_stats:
    input:
        bam="results/mapped/{sample}.bam",  #Optional input, specify target regions
    output:
        "results/qc/samtools_stats/{sample}.txt",
    log:
        "logs/samtools_stats/{sample}.log",
    params:
        extra="",  # Optional: extra arguments.
    wrapper:
        "v9.4.2/bio/samtools/stats"


# make QC report
# -----------------------------------------------------
rule fastqc:
    input:
        fastq="reads/{sample}_{read}_001.fastq.gz"
    output:
        html="results/fastqc/{sample}_{read}_fastqc.html",
        zip="results/fastqc/{sample}_{read}_fastqc.zip",
    log:
        "results/fastqc/{sample}_{read}.log",
    threads: 1
    params:
        extra="--quiet",
    wrapper:
        "v7.6.0/bio/fastqc"


# run multiQC on tool output
# -----------------------------------------------------
rule multiqc:
    input:
        expand(
            "results/fastqc/{sample}_{read}_fastqc.{ext}",
            sample=SAMPLES,
            read=["R1", "R2"],
            ext=["html", "zip"],
        ),
        expand(
            "results/qc/samtools_stats/{sample}.txt",
            sample=SAMPLES,
        ),
    output:
        report="results/qc/multiqc_report.html",
    log:
        "results/multiqc/multiqc.log",
    params:
        extra="--verbose --dirs",
    wrapper:
        "v8.1.1/bio/multiqc"
