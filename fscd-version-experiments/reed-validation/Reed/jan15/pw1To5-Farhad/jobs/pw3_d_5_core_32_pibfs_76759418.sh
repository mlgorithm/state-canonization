#!/bin/bash
#SBATCH --account=NN9535K --job-name=76759418
#SBATCH --partition=bigmem
#SBATCH --time=1-00:00:00
#SBATCH --ntasks=1 --cpus-per-task=32
#SBATCH --output=../cluster-outputs/slurm_%x_%j.out
#SBATCH --error=../cluster-outputs/slurm_%x_%j.err
#SBATCH --mem-per-cpu=2G
../program/Build/./treewidzard -atp  pw = 3 -pl  -nthreads 64 ParallelIsomorphismBreadthFirstSearch ../inputs/d_5.txt > ../program-outputs/pw3_d_5_core_32_pibfs_76759418.txt
exit 0
