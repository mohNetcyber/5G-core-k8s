#!/usr/bin/env bash
# Lance N UE (EF8 / T9). Usage : multi-ue.sh <N>
set -euo pipefail
N="${1:-5}"
cd "$(dirname "$0")"
sudo nr-ue -c config/open5gs-ue.yaml -n "$N"
