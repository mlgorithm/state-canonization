#!/bin/bash
#SBATCH --account=NN9535K --job-name=p5d3_64256
#SBATCH --partition=bigmem
#SBATCH --mail-type=ALL --mail-user=farhad.vadiee@uib.no
#SBATCH --time=1-00:00:00
#SBATCH --ntasks=1 --cpus-per-task=64
#SBATCH --output=slurm_%x_%j.out
#SBATCH --error=slurm_%x_%j.err
#SBATCH --mem-per-cpu=2G
/cluster/home/farhadvadiee/2023/jan2/TreeWidzard-Engine-main/Build/./treewidzard -atp  pw = 5 -pl -premise  -nthreads 256  ParallelIsomorphismBreadthFirstSearch conj_pw_5.txt > conj_pw_5_64_256.out
exit 0

