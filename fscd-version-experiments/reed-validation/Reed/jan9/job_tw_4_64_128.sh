#!/bin/bash
#SBATCH --account=NN9535K --job-name=t4d3_64128
#SBATCH --partition=bigmem
#SBATCH --mail-type=ALL --mail-user=farhad.vadiee@uib.no
#SBATCH --time=14-00:00:00
#SBATCH --ntasks=1 --cpus-per-task=64
#SBATCH --output=slurm_%x_%j.out
#SBATCH --error=slurm_%x_%j.err
#SBATCH --mem-per-cpu=4G
/cluster/home/farhadvadiee/2023/jan2/TreeWidzard-Engine-main/Build/./treewidzard -atp  tw = 4 -pl -premise  -nthreads 128  ParallelIsomorphismBreadthFirstSearch conj_tw_4.txt > conj_tw_4_64_128.out
exit 0

