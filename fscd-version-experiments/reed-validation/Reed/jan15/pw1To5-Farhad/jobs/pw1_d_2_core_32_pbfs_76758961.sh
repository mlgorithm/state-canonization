#!/bin/bash
#SBATCH --account=NN9535K --job-name=76758961
#SBATCH --partition=bigmem
#SBATCH --time=1-00:00:00
#SBATCH --ntasks=1 --cpus-per-task=32
#SBATCH --output=../cluster-outputs/slurm_%x_%j.out
#SBATCH --error=../cluster-outputs/slurm_%x_%j.err
#SBATCH --mem-per-cpu=2G
../program/Build/./treewidzard -atp  pw = 1 -pl  -nthreads 64 ParallelBreadthFirstSearch ../inputs/d_2.txt > ../program-outputs/pw1_d_2_core_32_pbfs_76758961.txt
exit 0
