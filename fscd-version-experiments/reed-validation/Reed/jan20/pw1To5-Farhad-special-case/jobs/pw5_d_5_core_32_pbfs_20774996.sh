#!/bin/bash
#SBATCH --account=NN9535K
#SBATCH --job-name=20774996
#SBATCH --time=1-00:00:00
#SBATCH --mem-per-cpu=5G
#SBATCH --output=../cluster-outputs/slurm_%x_%j.out
#SBATCH --error=../cluster-outputs/slurm_%x_%j.err
#SBATCH --ntasks=1 --cpus-per-task=32 --ntasks-per-node=1
module load GCC/11.3.0 
../program/Build/./treewidzard -atp  pw = 5 -pl  -nthreads 64 ParallelBreadthFirstSearch ../inputs/d_5.txt > ../program-outputs/pw5_d_5_core_32_pbfs_20774996.txt
exit 0
