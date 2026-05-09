#!/bin/bash
#SBATCH --account=NN9535K --job-name=76702990
#SBATCH --partition=bigmem
#SBATCH --time=1-00:00:00
#SBATCH --ntasks=1 --cpus-per-task=32
#SBATCH --output=../cluster-outputs/slurm_%x_%j.out
#SBATCH --error=../cluster-outputs/slurm_%x_%j.err
#SBATCH --mem-per-cpu=2G
../program/Build/./treewidzard -atp  tw = 1 -pl  -nthreads 64 ParallelIsomorphismBreadthFirstSearch ../inputs/d_5.txt > ../program-outputs/tw1_d_5_core_32_pibfs_76702990.txt
exit 0
