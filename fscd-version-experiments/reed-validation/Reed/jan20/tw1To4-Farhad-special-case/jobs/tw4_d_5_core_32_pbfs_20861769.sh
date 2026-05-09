#!/bin/bash
#SBATCH --account=NN9535K
#SBATCH --job-name=20861769
#SBATCH --time=1-00:00:00
#SBATCH --mem-per-cpu=5G
#SBATCH --output=../cluster-outputs/slurm_%x_%j.out
#SBATCH --error=../cluster-outputs/slurm_%x_%j.err
#SBATCH --ntasks=1 --cpus-per-task=32 --ntasks-per-node=1
module load GCC/11.3.0 
../program/Build/./treewidzard -atp  tw = 4 -pl  -nthreads 64 ParallelBreadthFirstSearch ../inputs/d_5.txt > ../program-outputs/tw4_d_5_core_32_pbfs_20861769.txt
exit 0
