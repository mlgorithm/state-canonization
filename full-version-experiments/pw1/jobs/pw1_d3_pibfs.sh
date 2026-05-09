#!/bin/bash
#SBATCH --account=NN9535K
#SBATCH --job-name=pw1_d3_pibfs
#SBATCH --time=1-00:00:00
#SBATCH --mem-per-cpu=5G
#SBATCH --ntasks=1 --cpus-per-task=32 --ntasks-per-node=1
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

"${TREEWIDZARD_BIN}" -atp pw = 1 -pl -nthreads 32 ParallelIsomorphismBreadthFirstSearch properties/d_3.txt > outputs/pw1_d3_pibfs.txt
