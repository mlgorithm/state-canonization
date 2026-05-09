#!/bin/bash
#SBATCH --account=NN9535K --job-name=78654016
#SBATCH --partition=bigmem
#SBATCH --time=1-00:00:00
#SBATCH --ntasks=1 --cpus-per-task=32
#SBATCH --output=../cluster-outputs/slurm_%x_%j.out
#SBATCH --error=../cluster-outputs/slurm_%x_%j.err
#SBATCH --mem-per-cpu=8G
../program/Build/./treewidzard -atp  pw = 1 -pl  -nthreads 64 ParallelBreadthFirstSearch ../inputs/d_3.txt > ../program-outputs/pw1_d_3_core_32_pbfs_78654016.txt
exit 0
