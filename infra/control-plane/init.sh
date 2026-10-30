#!/usr/bin/env bash
# Initialisation du control plane (sur k8s-cp).
set -euo pipefail

kubeadm init --config "$(dirname "$0")/kubeadm-config.yaml"

mkdir -p "$HOME/.kube"
cp /etc/kubernetes/admin.conf "$HOME/.kube/config"
chown "$(id -u):$(id -g)" "$HOME/.kube/config"

echo "Récupérer la commande de join avec : kubeadm token create --print-join-command"
echo "Ne PAS la commiter (infra/workers/join.sh est dans .gitignore)."
