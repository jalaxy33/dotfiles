#!/usr/bin/env bash
#
# lib/bash.sh -- bash helpers. Sourced, never run.
#
# For bash scripts only; the sh scripts use lib/posix.sh.
#
# Usage:
#   . "$(dirname -- "${BASH_SOURCE[0]}")/../lib/bash.sh"
#   ensure_command "$CURRENT_DIR/some_script"
#

# Sourcing does not change $0, so this is still the calling script.
SCRIPT_NAME=${0##*/}

# ensure_command FILE - exit when FILE is missing or not executable
ensure_command() {
  local cmd=$1
  if [[ ! -f $cmd || ! -x $cmd ]]; then
    echo "$SCRIPT_NAME: error: $cmd missing or not executable." >&2
    exit 1
  fi
}
