#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

for experiment in pw1 pw2 pw3 pw4 pw5 tw1 tw2 tw3 tw4; do
  (
    cd "$experiment"
    python3 create_property_files.py
    python3 create_jobs.py
  )
done
