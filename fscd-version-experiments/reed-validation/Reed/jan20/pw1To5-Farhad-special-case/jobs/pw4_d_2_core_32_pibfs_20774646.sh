#!/bin/bash
#SBATCH --account=NN9535K
#SBATCH --partition=bigmem
#SBATCH --job-name=20774646
#SBATCH --time=1-00:00:00
#SBATCH --mem-per-cpu=10G
#SBATCH --output=../cluster-outputs/slurm_%x_%j.out
#SBATCH --error=../cluster-outputs/slurm_%x_%j.err
#SBATCH --ntasks=1 --cpus-per-task=32 --ntasks-per-node=1
module load GCC/11.3.0 
../program/Build/./treewidzard -atp  pw = 4 -pl  -nthreads 64 ParallelIsomorphismBreadthFirstSearch ../inputs/d_2.txt > ../program-outputs/pw4_d_2_core_32_pibfs_20774646.txt
exit 0
