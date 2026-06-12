#!/usr/bin/env python3
"""
Convert a cohort CSV to YAML students block.

Usage:
    python3 data/csv/csv-to-yaml.py data/csv/ce13.csv

Expected CSV columns: No., Full Name, Nickname, GitHub Username, Discord Username
Output is a YAML block matching data/cohorts.yaml format.
"""

import csv
import sys


def convert(csv_path):
    with open(csv_path) as f:
        reader = csv.DictReader(f)
        for row in reader:
            name = row["Full Name"].strip().replace(",", "")
            github = row["GitHub Username"].strip()
            discord = row["Discord Username"].strip()
            print(f'      - name: "{name}"')
            print(f'        aws_username: "{github}"')
            print(f'        github_username: "{github}"')
            print(f'        discord_username: "{discord}"')


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <csv_file>", file=sys.stderr)
        sys.exit(1)
    convert(sys.argv[1])
