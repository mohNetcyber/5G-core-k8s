#!/usr/bin/env bash
# Préparation OS (à exécuter sur chaque nœud K8s). Idempotent.
set -euo pipefail

swapoff -a
sed -i '/ swap / s/^/#/' /etc/fstab

cat > /etc/modules-load.d/k8s.conf <<EOM
overlay
br_netfilter
sctp
EOM
modprobe overlay
modprobe br_netfilter
modprobe sctp

cat > /etc/sysctl.d/99-k8s.conf <<EOM
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOM
sysctl --system

apt-get update
apt-get install -y chrony curl gnupg apt-transport-https ca-certificates
systemctl enable --now chrony
