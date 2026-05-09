#!/bin/bash
#SBATCH --account=NN9535K --job-name=78663629
#SBATCH --partition=bigmem
#SBATCH --time=1-00:00:00
#SBATCH --ntasks=1 --cpus-per-task=32
#SBATCH --output=../cluster-outputs/slurm_%x_%j.out
#SBATCH --error=../cluster-outputs/slurm_%x_%j.err
#SBATCH --mem-per-cpu=8G
../program/Build/./treewidzard -atp  tw = 3 -pl  -nthreads 64 ParallelIsomorphismBreadthFirstSearch ../inputs/d_3.txt > ../program-outputs/tw3_d_3_core_32_pibfs_78663629.txt
exit 0
