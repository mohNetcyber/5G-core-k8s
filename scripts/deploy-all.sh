#!/usr/bin/env bash
# Redéploiement depuis zéro du plan applicatif (ENF2 : < 1 h).
# Prérequis : cluster kubeadm déjà initialisé (infra/control-plane/init.sh) et workers joints.
set -euo pipefail
cd "$(dirname "$0")/.."

make addons
make monitoring
make core
echo "Cœur déployé. Sur ran-sim : bash ran/run-gnb.sh puis bash ran/run-ue.sh"
