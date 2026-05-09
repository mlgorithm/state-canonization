#!/bin/bash
#SBATCH --account=NN9535K
#SBATCH --partition=bigmem
#SBATCH --job-name=pw5_d3_premise_pibfs
#SBATCH --time=1-00:00:00
#SBATCH --mem-per-cpu=5G
#SBATCH --ntasks=1 --cpus-per-task=64 --ntasks-per-node=1
set -euo pipefail

EXPERIMENT_DIR="${SLURM_SUBMIT_DIR:-$(pwd)}"
cd "$EXPERIMENT_DIR"

CONFIG_FILE="../config.env"
if [ -f "$CONFIG_FILE" ]; then
  source "$CONFIG_FILE"
fi

: "${TREEWIDZARD_BIN:?Set TREEWIDZARD_BIN or edit ../config.env}"

mkdir -p logs outputs
test -f "properties/d_3.txt"

"${TREEWIDZARD_BIN}" -atp pw = 5 -pl -premise -nthreads 64 ParallelIsomorphismBreadthFirstSearch properties/d_3.txt > outputs/pw5_d3_premise_pibfs.txt
