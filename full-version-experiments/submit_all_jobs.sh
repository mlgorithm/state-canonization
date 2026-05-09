#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

for experiment in pw1 pw2 pw3 pw4 pw5 tw1 tw2 tw3 tw4; do
  (
    cd "$experiment"
    ./submit_jobs.sh
  )
done
