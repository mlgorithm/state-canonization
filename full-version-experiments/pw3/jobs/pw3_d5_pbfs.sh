#!/bin/bash
#SBATCH --account=NN9535K
#SBATCH --job-name=pw3_d5_pbfs
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
test -f "properties/d_5.txt"

"${TREEWIDZARD_BIN}" -atp pw = 3 -pl -nthreads 32 ParallelBreadthFirstSearch properties/d_5.txt > outputs/pw3_d5_pbfs.txt
