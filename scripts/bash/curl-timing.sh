#!/usr/bin/env bash
set -euo pipefail

# Continuously prints Curl DNS, TCP, TLS, and time-to-first-byte timings.
usage() {
  echo "Usage: $0 URI" >&2
  exit 1
}

uri="${1:-}"

if [[ -z "$uri" ]]; then
  usage
fi

while true; do
  curl -w "dns_resolution: %{time_namelookup}, tcp_established: %{time_connect}, ssl_handshake_done: %{time_appconnect}, TTFB: %{time_starttransfer}\n" -o /dev/null -s "$uri"
done
