# Pandora paper full pipeline

Snakemake pipeline to handle the installation and running of all pipelines in the pandora paper. 

The version used in the pandora paper has tag `pandora_paper_tag1`.

# Running

## Requirements

### Dependencies
* python 3.6+;
* singularity 2.4.1+;

### Setting up virtualenv
`./setup.sh`

## Running on the paper data on an LSF cluster:

1. `git checkout pandora_paper_tag1`
2. `source venv/bin/activate`
3. `bash scripts/submit_lsf.sh`
