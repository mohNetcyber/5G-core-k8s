#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
nr-gnb -c config/open5gs-gnb.yaml
