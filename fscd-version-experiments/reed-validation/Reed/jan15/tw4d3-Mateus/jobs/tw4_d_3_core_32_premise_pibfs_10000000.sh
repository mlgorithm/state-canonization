#!/bin/bash
#SBATCH --account=NN9535K --job-name=tw4_d3_32
#SBATCH --partition=bigmem
#SBATCH --time=14-00:00:00
#SBATCH --ntasks=1 --cpus-per-task=32
#SBATCH --output=../cluster-outputs/slurm_%x_%j.out
#SBATCH --error=../cluster-outputs/slurm_%x_%j.err
#SBATCH --mem-per-cpu=8G
../program/Build/./treewidzard -atp  tw = 4 -pl -premise -nthreads 64 ParallelIsomorphismBreadthFirstSearch ../inputs/d_3.txt > ../program-outputs/tw4_d_3_core_32_premise_pibfs_10000000.txt
exit 0
