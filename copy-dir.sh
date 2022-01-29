#!/bin/bash

# Request an hour of runtime:
SBATCH --time=1:00:00

# Default resources are 1 core with 2.8GB of memory.
# Use more memory (4GB):
#SBATCH --mem=4G

# Specify a job name:
SBATCH -J copy-dir

# Notify details about job
SBATCH --mail-type=ALL

# Run a command
cp -r <source/dir/path> <destination/dir/path>
