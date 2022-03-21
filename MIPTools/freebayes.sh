#!/bin/bash

# Request a specific partition:
# The partitions available are: batch, gpu, and bigmem
#SBATCH --partition=batch

# Configure runtime, memory, and CPUs:
#SBATCH --time=48:00:00
#SBATCH --mem=200G
#SBATCH --cpus-per-task=32

# Email details about job:
#SBATCH --mail-user=example@mail.com
#SBATCH --mail-type=ALL

# Path to container
miptools="miptools_v0.4.0.sif"

# Paths to bind to container
project_resources="test-data/DR1_project_resources"
species_resources="test-data/pf_species_resources"
wrangler_dir="test-data/wrangler"
variant_dir="test-data/variant"

# Freebayes options
bam_dir="/opt/analysis/padded_bams"
fastq_dir="/opt/analysis/padded_fastqs"
output_vcf="/opt/analysis/variants.vcf.gz"
targets_file="/opt/project_resources/targets.tsv"
settings_file="/opt/analysis/settings.txt"
fastq_padding=20

# To access python help page run:
# singularity exec miptools_v0.4.0.sif python /opt/src/freebayes_caller.py --help

# Example run of Freebayes script
# Things to watch out for:
# 1. To feed additional Freebayes options using --extra-freebayes-options, you
#    must use "+" instead of "-". For instance, instead of 
#    "--pooled-continuous", you must write "++pooled+continuous".
# 2. To pass multiple extra Freebayes options, separate the options by a space.
# 3. If settings have been changed in the notebook, you must save the settings
#    using `mip.write_analysis_settings(settings, wdir + settings_file)`
singularity exec \
    --bind ${project_resources}:/opt/project_resources \
    --bind ${species_resources}:/opt/species_resources \
    --bind ${wrangler_dir}:/opt/data \
    --bind ${variant_dir}:/opt/analysis \
    ${miptools} python /opt/src/freebayes_caller.py \
    --bam-dir ${bam_dir} --fastq-dir ${fastq_dir} --output-vcf ${output_vcf} \
    --settings-file ${settings_file} --targets-file ${targets_file} \
    --fastq-padding ${fastq_padding} --threads=${SLURM_CPUS_PER_TASK} \
    --extra-freebayes-options ++pooled+continuous \
    ++min+alternate+fraction=0.01 ++min+alternate+count=2 ++haplotype+length=3 \
    ++min+alternate+total=10 ++use+best+n+alleles=70 \
    ++genotype+qualities ++gvcf ++gvcf+dont+use+chunk=true
