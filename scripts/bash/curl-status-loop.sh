#!/usr/bin/env bash
set -euo pipefail

# Runs a fixed-count Curl status and timing probe for an HTTP endpoint.
usage() {
  echo "Usage: $0 URI [COUNT]" >&2
  exit 1
}

uri="${1:-}"
count="${2:-100}"

if [[ -z "$uri" ]]; then
  usage
fi

for ((i = 1; i <= count; i++)); do
  curl -k -o /dev/null -s -w "DNS-Lookup [%{time_namelookup}] Time-Connect [%{time_connect}] Time-PreTransfer [%{time_pretransfer}] Time-StartTransfer [%{time_starttransfer}] Total-Time [%{time_total}] Response-Code [%{http_code}]\n" "$uri"
done
