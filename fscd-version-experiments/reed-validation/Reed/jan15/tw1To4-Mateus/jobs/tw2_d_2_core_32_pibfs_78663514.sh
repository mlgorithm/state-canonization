#!/bin/bash
#SBATCH --account=NN9535K --job-name=78663514
#SBATCH --partition=bigmem
#SBATCH --time=1-00:00:00
#SBATCH --ntasks=1 --cpus-per-task=32
#SBATCH --output=../cluster-outputs/slurm_%x_%j.out
#SBATCH --error=../cluster-outputs/slurm_%x_%j.err
#SBATCH --mem-per-cpu=8G
../program/Build/./treewidzard -atp  tw = 2 -pl  -nthreads 64 ParallelIsomorphismBreadthFirstSearch ../inputs/d_2.txt > ../program-outputs/tw2_d_2_core_32_pibfs_78663514.txt
exit 0
