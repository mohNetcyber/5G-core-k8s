#!/usr/bin/env bash
set -euo pipefail
kubectl delete namespace open5gs --ignore-not-found
helm uninstall kps -n monitoring 2>/dev/null || true
