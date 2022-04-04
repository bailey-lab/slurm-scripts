#!/bin/bash

# Request a specific partition:
# The partitions available are: batch, gpu, and bigmem
#SBATCH --partition=bigmem

# Configure runtime, memory, and CPUs:
#SBATCH --time=24:00:00
#SBATCH --mem=600G
#SBATCH --cpus-per-task=32

# Email details about job:
#SBATCH --mail-user=example@mail.com
#SBATCH --mail-type=ALL

# Path to container
miptools=/nfs/jbailey5/baileyweb/bailey_share/software/MIPTools/download/miptools_v0.4.0.sif

# Paths to bind to container
project_resources=/nfs/jbailey5/baileyweb/aydemiro/data/resources/project_resources/heome
fastq_dir=/users/dgiesbre/scratch/220202_tes/DR2/mergedfastq_downsample
wrangler_dir=/users/dgiesbre/scratch/220202_tes/DR2

# Wrangler options
probe_sets_used='HeOME96'
sample_sets_used='JJJ'
experiment_id='example_id'
sample_list='sample_list.tsv'
min_capture_length=30

singularity run \
    -B ${project_resources}:/opt/project_resources \
    -B ${fastq_dir}:/opt/data \
    -B ${wrangler_dir}:/opt/analysis \
    --app wrangler ${miptools} \
    -p ${probe_sets_used} -s ${sample_sets_used} -e ${experiment_id} \
    -l ${sample_list} -c ${SLURM_CPUS_PER_TASK} -m ${min_capture_length}
