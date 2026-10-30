#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
sudo nr-ue -c config/open5gs-ue.yaml
