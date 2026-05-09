#!/usr/bin/env python3
import csv
import json
import stat
from pathlib import Path


ROOT = Path(__file__).resolve().parent
WIDTHS = [("pw", width) for width in range(1, 6)] + [("tw", width) for width in range(1, 5)]


CREATE_PROPERTY_WRAPPER = """#!/usr/bin/env python3
from pathlib import Path
import sys

sys.dont_write_bytecode = True
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "shared"))

from experiment_tools import create_property_files

create_property_files(Path(__file__).resolve().parent)
"""


CREATE_JOBS_WRAPPER = """#!/usr/bin/env python3
from pathlib import Path
import sys

sys.dont_write_bytecode = True
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "shared"))

from experiment_tools import create_jobs

create_jobs(Path(__file__).resolve().parent)
"""


SUBMIT_JOBS = """#!/bin/bash
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
"""


def write_executable(path, content):
    path.write_text(content)
    path.chmod(path.stat().st_mode | stat.S_IXUSR | stat.S_IXGRP | stat.S_IXOTH)


def create_resource_overrides():
    source = ROOT.parent / "unfinished-reruns" / "unfinished_cases.csv"
    target = ROOT / "resource_overrides.csv"
    fields = ["experiment", "delta", "search_option", "search_type", "reason"]

    rows = []
    if source.exists():
        with source.open(newline="") as handle:
            for row in csv.DictReader(handle):
                width = row["width"].replace(" ", "")
                experiment = width.replace("=", "")
                rows.append({
                    "experiment": experiment,
                    "delta": row["max_degree"],
                    "search_option": "premise" if row["search_options"].strip() == "-premise" else "none",
                    "search_type": "pibfs" if row["search_type"] == "ParallelIsomorphismBreadthFirstSearch" else "pbfs",
                    "reason": row["reason"],
                })

    with target.open("w", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=fields)
        writer.writeheader()
        for row in sorted(rows, key=lambda item: (item["experiment"], int(item["delta"]), item["search_option"], item["search_type"])):
            writer.writerow(row)


def main():
    for kind, width in WIDTHS:
        name = f"{kind}{width}"
        folder = ROOT / name
        folder.mkdir(parents=True, exist_ok=True)
        for child in ("properties", "jobs", "logs", "outputs", "metadata"):
            (folder / child).mkdir(exist_ok=True)

        config = {
            "kind": kind,
            "width": width,
            "deltas": [2, 3, 4, 5],
            "search_options": ["none", "premise"],
            "search_types": ["pbfs", "pibfs"],
        }
        (folder / "experiment.json").write_text(json.dumps(config, indent=2) + "\n")
        write_executable(folder / "create_property_files.py", CREATE_PROPERTY_WRAPPER)
        write_executable(folder / "create_jobs.py", CREATE_JOBS_WRAPPER)
        write_executable(folder / "submit_jobs.sh", SUBMIT_JOBS)

    create_resource_overrides()
    print(f"Created clean experiment layout under {ROOT}")


if __name__ == "__main__":
    main()
