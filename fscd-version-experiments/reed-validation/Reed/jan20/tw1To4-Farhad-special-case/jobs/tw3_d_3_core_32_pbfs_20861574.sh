#!/bin/bash
#SBATCH --account=NN9535K
#SBATCH --job-name=20861574
#SBATCH --time=1-00:00:00
#SBATCH --mem-per-cpu=5G
#SBATCH --output=../cluster-outputs/slurm_%x_%j.out
#SBATCH --error=../cluster-outputs/slurm_%x_%j.err
#SBATCH --ntasks=1 --cpus-per-task=32 --ntasks-per-node=1
module load GCC/11.3.0 
../program/Build/./treewidzard -atp  tw = 3 -pl  -nthreads 64 ParallelBreadthFirstSearch ../inputs/d_3.txt > ../program-outputs/tw3_d_3_core_32_pbfs_20861574.txt
exit 0
