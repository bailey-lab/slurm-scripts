#!/bin/bash

# Set runtime
#SBATCH --time=4:00:00

# Set memory allocation
# Default on Oscar is 2.8GB of memory
#SBATCH --mem=4G

# Specify a job name
#SBATCH --job-name=download-data-array

# Email details about job
#SBATCH --mail-user=example@mail.com
#SBATCH --mail-type=ALL

# Use a job array to download each file
#SBATCH --array=1-14

# Configure output save location
#SBATCH --output=/users/<username>/slurm-outputs/slurm-%A_%a.out

# Define variables
dir="vcf-downloads"
url="ftp://ngs.sanger.ac.uk/production/malaria/pfcommunityproject/Pf6/Pf_6_vcf"
regex="*${SLURM_ARRAY_TASK_ID}_v3.final.vcf.gz"

# Print regex and run wget
echo ${regex}
wget --recursive --no-host-directories --cut-dirs=5 --directory-prefix=${dir} --accept ${regex} ${url}
