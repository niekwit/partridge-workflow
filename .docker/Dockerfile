FROM condaforge/miniforge3:latest
LABEL io.github.snakemake.containerized="true"
LABEL io.github.snakemake.conda_env_hash="83c69967d40fa7a6afa004f7d66ef2535dbff17c7b726f546e54cf3686c24850"

# Step 2: Retrieve conda environments

# Conda environment:
#   source: https://github.com/snakemake/snakemake-wrappers/raw/v7.2.0/bio/bwa-mem2/index/environment.yaml
#   prefix: /conda-envs/8d14bc08968a8a0c4ae533ed82f36e85
#   channels:
#     - conda-forge
#     - bioconda
#     - nodefaults
#   dependencies:
#     - bwa-mem2 =2.3
RUN mkdir -p /conda-envs/8d14bc08968a8a0c4ae533ed82f36e85
ADD https://github.com/snakemake/snakemake-wrappers/raw/v7.2.0/bio/bwa-mem2/index/environment.yaml /conda-envs/8d14bc08968a8a0c4ae533ed82f36e85/environment.yaml

# Conda environment:
#   source: https://github.com/snakemake/snakemake-wrappers/raw/v7.6.0/bio/fastqc/environment.yaml
#   prefix: /conda-envs/fc3f74ad3a4edd6540650576745e8ff5
#   channels:
#     - conda-forge
#     - bioconda
#     - nodefaults
#   dependencies:
#     - fastqc =0.12.1
#     - snakemake-wrapper-utils =0.8.0
RUN mkdir -p /conda-envs/fc3f74ad3a4edd6540650576745e8ff5
ADD https://github.com/snakemake/snakemake-wrappers/raw/v7.6.0/bio/fastqc/environment.yaml /conda-envs/fc3f74ad3a4edd6540650576745e8ff5/environment.yaml

# Conda environment:
#   source: https://github.com/snakemake/snakemake-wrappers/raw/v8.1.1/bio/multiqc/environment.yaml
#   prefix: /conda-envs/d644a06128ee144c2c0f210018caa0b9
#   channels:
#     - conda-forge
#     - bioconda
#     - nodefaults
#   dependencies:
#     - multiqc =1.33
#     - snakemake-wrapper-utils =0.8.0
RUN mkdir -p /conda-envs/d644a06128ee144c2c0f210018caa0b9
ADD https://github.com/snakemake/snakemake-wrappers/raw/v8.1.1/bio/multiqc/environment.yaml /conda-envs/d644a06128ee144c2c0f210018caa0b9/environment.yaml

# Conda environment:
#   source: https://github.com/snakemake/snakemake-wrappers/raw/v9.4.1/bio/bwa-mem2/mem/environment.yaml
#   prefix: /conda-envs/704e387e80962576d78414ca198a228c
#   channels:
#     - conda-forge
#     - bioconda
#     - nodefaults
#   dependencies:
#     - bwa-mem2 =2.3
#     - samtools =1.23.1
#     - picard-slim =3.4.0
#     - snakemake-wrapper-utils =0.8.0
RUN mkdir -p /conda-envs/704e387e80962576d78414ca198a228c
ADD https://github.com/snakemake/snakemake-wrappers/raw/v9.4.1/bio/bwa-mem2/mem/environment.yaml /conda-envs/704e387e80962576d78414ca198a228c/environment.yaml

# Conda environment:
#   source: https://github.com/snakemake/snakemake-wrappers/raw/v9.4.2/bio/samtools/stats/environment.yaml
#   prefix: /conda-envs/3bd7256db9da7df034ff60e200fe0d4d
#   channels:
#     - conda-forge
#     - bioconda
#     - nodefaults
#   dependencies:
#     - samtools =1.23.1
#     - snakemake-wrapper-utils =0.8.0
RUN mkdir -p /conda-envs/3bd7256db9da7df034ff60e200fe0d4d
ADD https://github.com/snakemake/snakemake-wrappers/raw/v9.4.2/bio/samtools/stats/environment.yaml /conda-envs/3bd7256db9da7df034ff60e200fe0d4d/environment.yaml

# Conda environment:
#   source: workflow/envs/get_genome.yaml
#   prefix: /conda-envs/68fc50fd41aeaa780499c43b4b87783e
#   name: get_genome
#   channels:
#     - conda-forge
#     - bioconda
#     - nodefaults
#   dependencies:
#     - gzip=1.14
#     - wget=1.21.4
RUN mkdir -p /conda-envs/68fc50fd41aeaa780499c43b4b87783e
COPY workflow/envs/get_genome.yaml /conda-envs/68fc50fd41aeaa780499c43b4b87783e/environment.yaml

# Conda environment:
#   source: workflow/envs/partridge.yaml
#   prefix: /conda-envs/a88e2015b3fb7d52ef8d15c2d4f59b97
#   name: partridge
#   channels:
#     - conda-forge
#     - bioconda
#     - nodefaults
#   dependencies:
#     - python=3.13
#     - pip
#     - r-base=4.5
#     - r-tidyverse=2.0.0
#     - r-openxlsx=4.2.8.1
#     - bioconda::bioconductor-genomicranges=1.62.1
#     - bioconda::bioconductor-biostrings=2.78.0
#     - bioconda::hmmer=3.4
#     - bioconda::samtools=1.22
#     - pip:
#         - et_xmlfile==2.0.0
#         - numpy==2.2.4
#         - openpyxl==3.1.5
#         - pandas==2.2.3
#         - psutil==6.1.1
#         - pyhmmer==0.11.0
#         - pysam==0.23.0
#         - python-dateutil==2.9.0.post0
#         - pytz==2025.2
#         - six==1.17.0
#         - tzdata==2025.2
RUN mkdir -p /conda-envs/a88e2015b3fb7d52ef8d15c2d4f59b97
COPY workflow/envs/partridge.yaml /conda-envs/a88e2015b3fb7d52ef8d15c2d4f59b97/environment.yaml

# Conda environment:
#   source: workflow/envs/trim_galore.yml
#   prefix: /conda-envs/f25143b31d35300a2e0f8a6febf76392
#   name: trim_galore
#   channels:
#     - conda-forge
#     - bioconda
#     - defaults
#   dependencies:
#     # Pinned to this exact build: build h9ee0642_0 was linked against a newer
#     # glibc than older hosts (e.g. Ubuntu 20.04, glibc 2.31) provide, causing
#     # `GLIBC_2.32/2.33/2.34 not found` errors. hf1b6044_1 fixes this (glibc <=2.16).
#     - trim-galore=2.2.0=hf1b6044_1
RUN mkdir -p /conda-envs/f25143b31d35300a2e0f8a6febf76392
COPY workflow/envs/trim_galore.yml /conda-envs/f25143b31d35300a2e0f8a6febf76392/environment.yaml

# Step 3: Generate conda environments

RUN conda env create --prefix /conda-envs/8d14bc08968a8a0c4ae533ed82f36e85 --file /conda-envs/8d14bc08968a8a0c4ae533ed82f36e85/environment.yaml && \
    conda env create --prefix /conda-envs/fc3f74ad3a4edd6540650576745e8ff5 --file /conda-envs/fc3f74ad3a4edd6540650576745e8ff5/environment.yaml && \
    conda env create --prefix /conda-envs/d644a06128ee144c2c0f210018caa0b9 --file /conda-envs/d644a06128ee144c2c0f210018caa0b9/environment.yaml && \
    conda env create --prefix /conda-envs/704e387e80962576d78414ca198a228c --file /conda-envs/704e387e80962576d78414ca198a228c/environment.yaml && \
    conda env create --prefix /conda-envs/3bd7256db9da7df034ff60e200fe0d4d --file /conda-envs/3bd7256db9da7df034ff60e200fe0d4d/environment.yaml && \
    conda env create --prefix /conda-envs/68fc50fd41aeaa780499c43b4b87783e --file /conda-envs/68fc50fd41aeaa780499c43b4b87783e/environment.yaml && \
    conda env create --prefix /conda-envs/a88e2015b3fb7d52ef8d15c2d4f59b97 --file /conda-envs/a88e2015b3fb7d52ef8d15c2d4f59b97/environment.yaml && \
    conda env create --prefix /conda-envs/f25143b31d35300a2e0f8a6febf76392 --file /conda-envs/f25143b31d35300a2e0f8a6febf76392/environment.yaml && \
    conda clean --all -y