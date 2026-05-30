#!/usr/bin/env bash
set -euo pipefail

# Runs tcpping with repeat and date output enabled for a target URI or host:port.
usage() {
  echo "Usage: $0 URI" >&2
  exit 1
}

uri="${1:-}"

if [[ -z "$uri" ]]; then
  usage
fi

tcpping -r 2 -d "$uri"
