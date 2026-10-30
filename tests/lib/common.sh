#!/usr/bin/env bash
# Utilitaires communs aux tests T1-T9.
# Prérequis : chrony synchronisé sur toutes les VMs avant de comparer des horodatages.

ts() { date +%s.%N; }

RESULTS_DIR="${RESULTS_DIR:-$(dirname "${BASH_SOURCE[0]}")/../../results/raw}"
mkdir -p "$RESULTS_DIR"

# usage : record <test_id> <essai> <valeur> [remarque]
record() {
  local f="$RESULTS_DIR/$1.csv"
  [ -f "$f" ] || echo "essai,valeur,remarque" > "$f"
  echo "$2,$3,${4:-}" >> "$f"
}
