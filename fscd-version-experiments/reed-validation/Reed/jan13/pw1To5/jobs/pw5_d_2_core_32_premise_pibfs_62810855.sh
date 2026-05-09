#!/bin/bash
#SBATCH --account=NN9535K --job-name=62810855
#SBATCH --partition=bigmem
#SBATCH --time=1-00:00:00
#SBATCH --ntasks=1 --cpus-per-task=32
#SBATCH --output=/cluster/projects/nn9535k/farhad/2023/conjectures/Reed/jan13/pw1To5/main-script/job-generation/../../cluster-outputs/slurm_%x_%j.out
#SBATCH --error=/cluster/projects/nn9535k/farhad/2023/conjectures/Reed/jan13/pw1To5/main-script/job-generation/../../cluster-outputs/slurm_%x_%j.err
#SBATCH --mem-per-cpu=2G
/cluster/home/farhadvadiee/2023/jan2/TreeWidzard-Engine-main/Build/./treewidzard -atp  pw = 5 -pl -premise -nthreads 64 ParallelIsomorphismBreadthFirstSearch ../../inputs/d_2.txt > /cluster/projects/nn9535k/farhad/2023/conjectures/Reed/jan13/pw1To5/main-script/job-generation/../../program-outputs/pw5_d_2_core_32_premise_pibfs_62810855.txt
exit 0
