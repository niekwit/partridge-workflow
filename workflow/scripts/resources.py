import os

# genome: (Ensembl species, Ensembl assembly name, UCSC build)
GENOMES = {
    "hg19": ("homo_sapiens", "GRCh37", "hg19"),
    "hg38": ("homo_sapiens", "GRCh38", "hg38"),
    "mm38": ("mus_musculus", "GRCm38", "mm10"),
    "mm39": ("mus_musculus", "GRCm39", "mm39"),
}


class Resources:
    """Gets URLs and file names of fasta and GTF files for a given genome and build"""

    # create genome directory
    os.makedirs("resources/", exist_ok=True)

    def __init__(self, genome, build):
        self.genome = genome
        self.build = build

        if genome not in GENOMES:
            raise ValueError(
                f"Genome {genome} not supported, choose from: {', '.join(GENOMES)}"
            )
        species, name, ucsc_build = GENOMES[genome]
        prefix = species.capitalize()

        # base URLs
        base_url_ens = f"https://ftp.ensembl.org/pub/release-{build}/"

        # create URLs for genome files
        self.fasta_url = f"{base_url_ens}fasta/{species}/dna/{prefix}.{name}.dna.primary_assembly.fa.gz"
        self.gtf_url = f"{base_url_ens}gtf/{species}/{prefix}.{name}.{build}.gtf.gz"

        # UCSC RepeatMasker table (rmsk), used to build the ERVK bed file
        self.repeat_mask_url = f"https://hgdownload.soe.ucsc.edu/goldenPath/{ucsc_build}/database/rmsk.txt.gz"

        # downloaded unzipped file names
        self.fasta = self._file_from_url(self.fasta_url)
        self.gtf = self._file_from_url(self.gtf_url)
        self.ervk_bed = "resources/ervk.bed"

    def _file_from_url(self, url):
        """Returns file path for unzipped downloaded file"""
        return f"resources/{os.path.basename(url).replace('.gz','')}"
