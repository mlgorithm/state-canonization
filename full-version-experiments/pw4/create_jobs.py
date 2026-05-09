#!/usr/bin/env python3
from pathlib import Path
import sys

sys.dont_write_bytecode = True
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "shared"))

from experiment_tools import create_jobs

create_jobs(Path(__file__).resolve().parent)
