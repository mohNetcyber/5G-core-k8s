#!/usr/bin/env python3
"""Statistiques d'un CSV de résultats : moyenne, min, max, écart-type.
Usage : python3 stats.py results/raw/t5.csv
"""
import csv
import statistics
import sys

path = sys.argv[1]
with open(path, newline="") as f:
    values = [float(r["valeur"]) for r in csv.DictReader(f)]

print(f"essais   : {len(values)}")
print(f"moyenne  : {statistics.mean(values):.3f}")
print(f"min      : {min(values):.3f}")
print(f"max      : {max(values):.3f}")
if len(values) > 1:
    print(f"ecart-type: {statistics.stdev(values):.3f}")
