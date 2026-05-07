#!/bin/bash -l
#SBATCH --job-name=nbody
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gpus=1
#SBATCH --partition=gpu-v100
#SBATCH --output nbody_%j.out
#SBATCH --error nbody_%j.err

vpkg_require gcc
vpkg_require cuda

make clean
make
srun ./nbody
