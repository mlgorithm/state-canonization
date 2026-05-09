#!/bin/bash
#SBATCH --account=NN9535K --job-name=78663657
#SBATCH --partition=bigmem
#SBATCH --time=1-00:00:00
#SBATCH --ntasks=1 --cpus-per-task=32
#SBATCH --output=../cluster-outputs/slurm_%x_%j.out
#SBATCH --error=../cluster-outputs/slurm_%x_%j.err
#SBATCH --mem-per-cpu=8G
../program/Build/./treewidzard -atp  tw = 4 -pl -premise -nthreads 64 ParallelBreadthFirstSearch ../inputs/d_3.txt > ../program-outputs/tw4_d_3_core_32_premise_pbfs_78663657.txt
exit 0
