#!/usr/bin/env bash
# Enchaîne les tests. Certains tests s'exécutent depuis ran-sim (T1-T3, T9).
set -euo pipefail
cd "$(dirname "$0")"
for t in t1-attach-time t2-throughput-iperf3 t3-latency-ping t4-kill-upf t5-kill-amf t6-kill-smf t7-drain-worker t8-cpu-stress t9-ue-scaling; do
  echo "=== $t ==="
  bash "./$t.sh"
done
