# import basic packages
import datetime
import subprocess

import pandas as pd
from snakemake.utils import validate
from scripts.resources import Resources as GenomeResources

# validate sample sheet and config file
# validate(samples, schema="../schemas/samples.schema.yaml")
# validate(config, schema="../schemas/config.schema.yaml")


def samples():
    df = pd.read_excel("config/metadata.xlsx")

    return df["Expt.ID"].tolist()


genome_resources = GenomeResources(config["genome"], config["ensembl_genome_build"])
GENOME = genome_resources.genome
SAMPLES = samples()


indent = 21


def conda_version():
    try:
        out = subprocess.run(
            ["conda", "--version"], capture_output=True, text=True, check=True
        )
        return out.stdout.strip().split(" ")[1]
    except (subprocess.CalledProcessError, FileNotFoundError):
        return "unknown"


cmdline = sys.argv[0]
for i in range(1, len(sys.argv)):
    if sys.argv[i].startswith("-"):
        cmdline += "\n" + (" " * indent) + sys.argv[i]
    else:
        cmdline += " " + sys.argv[i]

border_length = 70
logger.info("=" * border_length)
logger.info("")
logger.info("▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄")
logger.info("████████ ▄▄ █ ▄▄▀██ ▄▄▀█▄▄ ▄▄██ ▄▄▀█▄ ▄██ ▄▄▀██ ▄▄ ██ ▄▄▄███████")
logger.info("████████ ▀▀ █ ▀▀ ██ ▀▀▄███ ████ ▀▀▄██ ███ ██ ██ █▀▀██ ▄▄▄███████")
logger.info("████████ ████ ██ ██ ██ ███ ████ ██ █▀ ▀██ ▀▀ ██ ▀▀▄██ ▀▀▀███████")
logger.info("▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀")
logger.info("")
logger.info(
    "  Date:                " + datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
)
logger.info("  Python:              " + str(sys.version.split(" ")[0]))
logger.info("  Conda:               " + conda_version())
logger.info("  Snakemake:           " + snakemake.__version__)
logger.info("  partridge-workflow:  " + VERSION.replace("v", ""))
logger.info("  Genome:              " + config["genome"] + f" (Release {config['ensembl_genome_build']})")
logger.info("  Samples:             " + str(len(SAMPLES)))
logger.info("  Command:             " + cmdline)
logger.info("")

# Print contents of profile if parsed from command line
# i.e. if --profile flag used
if "--profile" in sys.argv:
    profile = sys.argv[sys.argv.index("--profile") + 1]
    file_ = os.path.join(profile, "config.yaml")
    logger.info("  Using profile:     " + file_)
    counter = 0
    with open(file_, "r") as file:
        for line in file:
            if counter == 0:
                logger.info("  Profile contents:  " + line.strip())
                counter += 1
            else:
                logger.info(" " * indent + line.strip())
                counter += 1

logger.info("=" * border_length)
logger.info("")


def multi_sample_run(SAMPLES):
    return len(SAMPLES) > 1


