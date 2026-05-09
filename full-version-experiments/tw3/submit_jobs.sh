#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

shopt -s nullglob
experiment_dir="$(pwd)"
mkdir -p logs outputs
for job in jobs/*.sh; do
  sbatch --chdir="$experiment_dir" \
    --output="$experiment_dir/logs/slurm_%x_%j.out" \
    --error="$experiment_dir/logs/slurm_%x_%j.err" \
    "$job"
done
