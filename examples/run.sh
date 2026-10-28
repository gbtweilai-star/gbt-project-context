#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
PYTHONPATH=src python -m gbt_project_context info
PYTHONPATH=src python -m gbt_project_context check --payload '{}'
PYTHONPATH=src python -m gbt_project_context run   --payload '{}'
