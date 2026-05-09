#!/bin/bash
#SBATCH --account=NN9535K --job-name=76759259
#SBATCH --partition=bigmem
#SBATCH --time=1-00:00:00
#SBATCH --ntasks=1 --cpus-per-task=32
#SBATCH --output=../cluster-outputs/slurm_%x_%j.out
#SBATCH --error=../cluster-outputs/slurm_%x_%j.err
#SBATCH --mem-per-cpu=2G
../program/Build/./treewidzard -atp  pw = 2 -pl  -nthreads 64 ParallelBreadthFirstSearch ../inputs/d_4.txt > ../program-outputs/pw2_d_4_core_32_pbfs_76759259.txt
exit 0
