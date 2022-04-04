#!/bin/bash

# Set runtime:
#SBATCH --time=4:00:00

# Set memory allocation:
# Default on Oscar is 2.8GB of memory
#SBATCH --mem=4G

# Specify a job name:
#SBATCH --job-name=download-data

# Email details about job:
#SBATCH --mail-user=example@mail.com
#SBATCH --mail-type=ALL

# Define variables
dir="download-vcfs"
url="ftp://ngs.sanger.ac.uk/production/malaria/pfcommunityproject/Pf6/Pf_6_vcf"

# Download data
wget --recursive --no-host-directories --cut-dirs=5 --directory-prefix=${dir} --accept "*vcf.gz" ${url}