#!/bin/bash
# Week 1 auto-check — Terminal/CLI fluency
# Verifies the required second-brain directory structure exists and README.md is non-empty.
# Per graded-assignments.md: this week is purely structural, no manual criteria.

set -e
cd "$(dirname "$0")/.."

REQUIRED_DIRS=(
  "agents"
  "tools"
  "state"
  "verticals/personal_brand"
  "verticals/company_brand"
  "web"
  "tests"
)

fail=0

for dir in "${REQUIRED_DIRS[@]}"; do
  if [ -d "$dir" ]; then
    echo "PASS: $dir exists"
  else
    echo "FAIL: $dir does not exist"
    fail=1
  fi
done

if [ -s "README.md" ]; then
  echo "PASS: README.md exists and is non-empty"
else
  echo "FAIL: README.md missing or empty"
  fail=1
fi

if [ "$fail" -eq 0 ]; then
  echo "WEEK 1: PASS"
else
  echo "WEEK 1: FAIL"
fi

exit $fail
