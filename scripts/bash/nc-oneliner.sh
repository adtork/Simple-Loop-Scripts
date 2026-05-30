#!/usr/bin/env bash
set -euo pipefail

# Continuously checks TCP reachability with NetCat and prints the current date.
usage() {
  echo "Usage: $0 IP PORT" >&2
  exit 1
}

ip="${1:-}"
port="${2:-}"

if [[ -z "$ip" || -z "$port" ]]; then
  usage
fi

while true; do
  nc -zv "$ip" "$port" || true
  sleep 1
  date
done
