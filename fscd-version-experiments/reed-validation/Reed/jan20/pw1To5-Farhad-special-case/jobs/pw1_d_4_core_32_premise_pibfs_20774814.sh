#!/bin/bash
#SBATCH --account=NN9535K
#SBATCH --job-name=20774814
#SBATCH --time=1-00:00:00
#SBATCH --mem-per-cpu=5G
#SBATCH --output=../cluster-outputs/slurm_%x_%j.out
#SBATCH --error=../cluster-outputs/slurm_%x_%j.err
#SBATCH --ntasks=1 --cpus-per-task=32 --ntasks-per-node=1
module load GCC/11.3.0 
../program/Build/./treewidzard -atp  pw = 1 -pl -premise -nthreads 64 ParallelIsomorphismBreadthFirstSearch ../inputs/d_4.txt > ../program-outputs/pw1_d_4_core_32_premise_pibfs_20774814.txt
exit 0
