#!/usr/bin/env bash
set -euo pipefail

# Continuously prints Curl status, total time, local/remote endpoints, and UTC timestamp.
usage() {
  echo "Usage: $0 URI" >&2
  exit 1
}

uri="${1:-}"

if [[ -z "$uri" ]]; then
  usage
fi

while true; do
  curl -w "%{http_code},%{time_total},%{local_ip},%{local_port},%{remote_ip},%{remote_port}," "$uri"
  date -u
  sleep 1
done
