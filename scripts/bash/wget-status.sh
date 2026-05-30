#!/usr/bin/env bash
set -euo pipefail

# Repeatedly checks an HTTP endpoint with wget and prints returned status codes.
usage() {
  echo "Usage: $0 URI [COUNT]" >&2
  exit 1
}

uri="${1:-}"
count="${2:-100}"

if [[ -z "$uri" ]]; then
  usage
fi

for ((i = 0; i <= count; i++)); do
  wget --spider -S "$uri" 2>&1 | grep "HTTP/" | awk '{print $2}'
done
