import csv
import json
import math
import stat
from pathlib import Path


SEARCH_TYPES = {
    "pbfs": "ParallelBreadthFirstSearch",
    "pibfs": "ParallelIsomorphismBreadthFirstSearch",
}

SEARCH_SUFFIX = {
    "pbfs": "pbfs",
    "pibfs": "pibfs",
}

RESOURCE_PROFILES = {
    "default": {
        "time": "1-00:00:00",
        "mem_per_cpu": "5G",
        "cpus_per_task": 32,
        "threads": 32,
        "partition": "",
        "submit_group": "standard",
        "note": "Default all-experiment profile: 32 CPUs, 32 threads, about 160G total memory.",
    },
    "OOM": {
        "time": "1-00:00:00",
        "mem_per_cpu": "16G",
        "cpus_per_task": 32,
        "threads": 32,
        "partition": "bigmem",
        "submit_group": "expanded-resource",
        "note": "Old run hit the memory cap. This uses about 512G total memory.",
    },
    "TIMEOUT": {
        "time": "1-00:00:00",
        "mem_per_cpu": "5G",
        "cpus_per_task": 32,
        "threads": 32,
        "partition": "",
        "submit_group": "expanded-resource",
        "note": "Old run hit the wall-time limit. This keeps the paper-matching one-day wall time.",
    },
    "SEGFAULT": {
        "time": "1-00:00:00",
        "mem_per_cpu": "5G",
        "cpus_per_task": 32,
        "threads": 32,
        "partition": "",
        "submit_group": "debug",
        "note": "Old run crashed quickly. This keeps the paper-matching one-day wall time for a debug rerun.",
    },
    "paper_flagship": {
        "time": "1-00:00:00",
        "mem_per_cpu": "2G",
        "cpus_per_task": 32,
        "threads": 32,
        "partition": "bigmem",
        "submit_group": "paper-flagship",
        "note": "Paper flagship profile for pw=5, Delta=3, premise, PIBFS, using the Saga-safe 32 CPU profile.",
    },
}


def load_config(experiment_dir):
    with (experiment_dir / "experiment.json").open() as handle:
        return json.load(handle)


def experiment_name(config):
    return f"{config['kind']}{config['width']}"


def width_argument(config):
    return f"{config['kind']} = {config['width']}"


def property_text(delta):
    chromatic_bound = math.ceil((delta + 3) / 2)
    return "\n".join([
        f"x := MaximumDegree_AtLeast({delta + 1})",
        "y := SimpleCliqueNumber_AtLeast(3)",
        "z := HasMultipleEdges()",
        f"w := ChromaticNumber_AtMost({chromatic_bound})",
        "Formula",
        "((NOT x) AND ((NOT y) AND (NOT z))) IMPLIES w",
        "",
    ])


def create_property_files(experiment_dir):
    config = load_config(experiment_dir)
    properties_dir = experiment_dir / "properties"
    metadata_dir = experiment_dir / "metadata"
    properties_dir.mkdir(exist_ok=True)
    metadata_dir.mkdir(exist_ok=True)

    rows = []
    for delta in config["deltas"]:
        chromatic_bound = math.ceil((delta + 3) / 2)
        property_name = f"d_{delta}"
        property_file = properties_dir / f"{property_name}.txt"
        property_file.write_text(property_text(delta))
        rows.append({
            "experiment": experiment_name(config),
            "property": property_name,
            "property_file": str(property_file.relative_to(experiment_dir)),
            "max_degree": delta,
            "chromatic_number": chromatic_bound,
        })

    with (metadata_dir / "properties.csv").open("w", newline="") as handle:
        fieldnames = ["experiment", "property", "property_file", "max_degree", "chromatic_number"]
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)

    print(f"Wrote {len(rows)} property files in {experiment_dir}")


def load_resource_overrides(root):
    path = root / "resource_overrides.csv"
    overrides = {}
    if not path.exists():
        return overrides
    with path.open(newline="") as handle:
        for row in csv.DictReader(handle):
            key = (row["experiment"], row["delta"], row["search_option"], row["search_type"])
            overrides[key] = row["reason"]
    return overrides


def profile_for(root, config, delta, search_option, search_type):
    overrides = load_resource_overrides(root)
    key = (experiment_name(config), str(delta), search_option, search_type)
    return RESOURCE_PROFILES[overrides.get(key, "default")]


def job_basename(config, delta, search_option, search_type, special=None):
    parts = [experiment_name(config), f"d{delta}"]
    if search_option == "premise":
        parts.append("premise")
    parts.append(SEARCH_SUFFIX[search_type])
    if special:
        parts.append(special)
    return "_".join(parts)


def job_script(experiment_dir, config, row):
    root = experiment_dir.parent
    job_name = row["job_name"]
    profile = row["profile"]
    partition = row["partition"]
    partition_line = f"#SBATCH --partition={partition}\n" if partition else ""
    property_path = f"properties/d_{row['delta']}.txt"
    output_path = f"outputs/{job_name}.txt"
    width_arg = width_argument(config)
    premise_arg = "-premise" if row["search_option"] == "premise" else ""
    search_method = SEARCH_TYPES[row["search_type"]]

    command_parts = [
        '"${TREEWIDZARD_BIN}"',
        "-atp",
        width_arg,
        "-pl",
        premise_arg,
        f"-nthreads {row['threads']}",
        search_method,
        property_path,
        ">",
        output_path,
    ]
    command = " ".join(part for part in command_parts if part)

    return f"""#!/bin/bash
#SBATCH --account=NN9535K
#SBATCH --job-name={job_name}
{partition_line}#SBATCH --time={row['time']}
#SBATCH --mem-per-cpu={row['mem_per_cpu']}
#SBATCH --ntasks=1 --cpus-per-task={row['cpus_per_task']} --ntasks-per-node=1
set -euo pipefail

EXPERIMENT_DIR="${{SLURM_SUBMIT_DIR:-$(pwd)}}"
cd "$EXPERIMENT_DIR"

CONFIG_FILE="../config.env"
if [ -f "$CONFIG_FILE" ]; then
  source "$CONFIG_FILE"
fi

: "${{TREEWIDZARD_BIN:?Set TREEWIDZARD_BIN or edit ../config.env}}"

module load GCC/11.3.0
mkdir -p logs outputs
test -f "{property_path}"

{command}
"""


def write_executable(path, content):
    path.write_text(content)
    path.chmod(path.stat().st_mode | stat.S_IXUSR | stat.S_IXGRP | stat.S_IXOTH)


def all_job_rows(root, experiment_dir, config):
    rows = []
    for delta in config["deltas"]:
        for search_option in config["search_options"]:
            for search_type in config["search_types"]:
                profile = profile_for(root, config, delta, search_option, search_type)
                name = job_basename(config, delta, search_option, search_type)
                rows.append({
                    "job_name": name,
                    "experiment": experiment_name(config),
                    "delta": delta,
                    "property_file": f"properties/d_{delta}.txt",
                    "search_option": search_option,
                    "search_type": search_type,
                    "profile": "default" if profile is RESOURCE_PROFILES["default"] else profile_name(profile),
                    **profile,
                })

    if config["kind"] == "pw" and config["width"] == 5:
        profile = RESOURCE_PROFILES["paper_flagship"]
        rows.append({
            "job_name": job_basename(config, 3, "premise", "pibfs", special="paper_flagship"),
            "experiment": experiment_name(config),
            "delta": 3,
            "property_file": "properties/d_3.txt",
            "search_option": "premise",
            "search_type": "pibfs",
            "profile": "paper_flagship",
            **profile,
        })

    return rows


def profile_name(profile):
    for name, candidate in RESOURCE_PROFILES.items():
        if profile is candidate:
            return name
    return "custom"


def create_jobs(experiment_dir):
    config = load_config(experiment_dir)
    root = experiment_dir.parent
    jobs_dir = experiment_dir / "jobs"
    metadata_dir = experiment_dir / "metadata"
    jobs_dir.mkdir(exist_ok=True)
    metadata_dir.mkdir(exist_ok=True)

    rows = all_job_rows(root, experiment_dir, config)
    for row in rows:
        script = job_script(experiment_dir, config, row)
        write_executable(jobs_dir / f"{row['job_name']}.sh", script)

    fieldnames = [
        "job_name", "experiment", "delta", "property_file", "search_option", "search_type",
        "profile", "time", "mem_per_cpu", "cpus_per_task", "threads", "partition",
        "submit_group", "note",
    ]
    with (metadata_dir / "jobs.csv").open("w", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()
        for row in rows:
            writer.writerow({field: row.get(field, "") for field in fieldnames})

    print(f"Wrote {len(rows)} job scripts in {experiment_dir}")
