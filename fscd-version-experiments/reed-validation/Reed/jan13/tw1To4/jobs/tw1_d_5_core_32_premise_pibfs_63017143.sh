#!/bin/bash
#SBATCH --account=NN9535K --job-name=63017143
#SBATCH --partition=bigmem
#SBATCH --time=1-00:00:00
#SBATCH --ntasks=1 --cpus-per-task=32
#SBATCH --output=/cluster/projects/nn9535k/farhad/2023/conjectures/Reed/jan13/tw1To4/main-script/job-generation/../../cluster-outputs/slurm_%x_%j.out
#SBATCH --error=/cluster/projects/nn9535k/farhad/2023/conjectures/Reed/jan13/tw1To4/main-script/job-generation/../../cluster-outputs/slurm_%x_%j.err
#SBATCH --mem-per-cpu=2G
/cluster/home/farhadvadiee/2023/jan13/TreeWidzard-Engine-main/Build/./treewidzard -atp  tw = 1 -pl -premise -nthreads 64 ParallelIsomorphismBreadthFirstSearch ../../inputs/d_5.txt > /cluster/projects/nn9535k/farhad/2023/conjectures/Reed/jan13/tw1To4/main-script/job-generation/../../program-outputs/tw1_d_5_core_32_premise_pibfs_63017143.txt
exit 0
