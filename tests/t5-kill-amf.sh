#!/usr/bin/env bash
# T5 : suppression du pod AMF.
# Mesure : t1 (pod recréé), t2 (pod Ready) et t3 (UE ré-enregistré, à relever dans les logs gNB/UE).
# Usage : t5-kill-amf.sh <nb_essais>
set -euo pipefail
source "$(dirname "$0")/lib/common.sh"

NS=open5gs
TRIALS="${1:-5}"

for i in $(seq 1 "$TRIALS"); do
  pod=$(kubectl -n "$NS" get pod -l app.kubernetes.io/name=amf -o jsonpath='{.items[0].metadata.name}')
  t0=$(ts)
  kubectl -n "$NS" delete pod "$pod" --wait=false
  kubectl -n "$NS" wait pod -l app.kubernetes.io/name=amf --for=condition=Ready --timeout=180s
  t2=$(ts)
  pod_recovery=$(echo "$t2 - $t0" | bc -l)
  record t5-pod "$i" "$pod_recovery" "t0=$t0 t2=$t2"
  echo "Essai $i : reprise pod = ${pod_recovery}s (relever t3 dans les logs gNB/UE)"
  sleep 30
done
