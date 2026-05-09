#!/bin/bash
#SBATCH --account=NN9535K --job-name=76702956
#SBATCH --partition=bigmem
#SBATCH --time=1-00:00:00
#SBATCH --ntasks=1 --cpus-per-task=32
#SBATCH --output=../cluster-outputs/slurm_%x_%j.out
#SBATCH --error=../cluster-outputs/slurm_%x_%j.err
#SBATCH --mem-per-cpu=2G
../program/Build/./treewidzard -atp  tw = 3 -pl -premise -nthreads 64 ParallelIsomorphismBreadthFirstSearch ../inputs/d_4.txt > ../program-outputs/tw3_d_4_core_32_premise_pibfs_76702956.txt
exit 0
