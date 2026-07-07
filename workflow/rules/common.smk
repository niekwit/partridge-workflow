# import basic packages
import datetime

import pandas as pd
from snakemake.utils import validate
from scripts.resources import Resources as GenomeResources

# validate sample sheet and config file
# validate(samples, schema="../schemas/samples.schema.yaml")
# validate(config, schema="../schemas/config.schema.yaml")

def samples():
    df = pd.read_excel("config/metadata.xlsx")

    return df["mouse"].tolist()


def multi_sample_run(SAMPLES):
    return len(SAMPLES) > 1