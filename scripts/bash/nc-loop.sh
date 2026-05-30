#!/usr/bin/env bash
set -euo pipefail

# Continuously checks TCP reachability with NetCat and logs failures to test.log.
usage() {
  echo "Usage: $0 IP PORT" >&2
  exit 1
}

ip="${1:-}"
port="${2:-}"

if [[ -z "$ip" || -z "$port" ]]; then
  usage
fi

timeoutSecs=5
while true; do
  if nc -z -v -w "$timeoutSecs" "$ip" "$port" &>/dev/null; then
    echo "Server is up,$(date +"%d/%m/%Y %H:%M:%S")"
  else
    echo "Server is DOWN-check logs!,$(date +"%d/%m/%Y %H:%M:%S")" >> test.log
  fi
  sleep 1
done
