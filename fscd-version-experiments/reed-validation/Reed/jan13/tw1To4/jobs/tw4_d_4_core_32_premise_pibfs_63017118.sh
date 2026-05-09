#!/bin/bash
#SBATCH --account=NN9535K --job-name=63017118
#SBATCH --partition=bigmem
#SBATCH --time=1-00:00:00
#SBATCH --ntasks=1 --cpus-per-task=32
#SBATCH --output=/cluster/projects/nn9535k/farhad/2023/conjectures/Reed/jan13/tw1To4/main-script/job-generation/../../cluster-outputs/slurm_%x_%j.out
#SBATCH --error=/cluster/projects/nn9535k/farhad/2023/conjectures/Reed/jan13/tw1To4/main-script/job-generation/../../cluster-outputs/slurm_%x_%j.err
#SBATCH --mem-per-cpu=2G
/cluster/home/farhadvadiee/2023/jan13/TreeWidzard-Engine-main/Build/./treewidzard -atp  tw = 4 -pl -premise -nthreads 64 ParallelIsomorphismBreadthFirstSearch ../../inputs/d_4.txt > /cluster/projects/nn9535k/farhad/2023/conjectures/Reed/jan13/tw1To4/main-script/job-generation/../../program-outputs/tw4_d_4_core_32_premise_pibfs_63017118.txt
exit 0
