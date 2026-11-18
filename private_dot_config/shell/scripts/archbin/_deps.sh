#!/usr/bin/env bash
#
# _deps.sh -- shared code for the archbin/ensure-* scripts. Sourced, never run.
#
# Usage, in an ensure-* script:
#   . "$(dirname -- "${BASH_SOURCE[0]}")/_deps.sh"
#   usage() { ... }                  # called by deps_init on -h/--help
#   deps_init "$@"                   # PATH, args, tools, archlinux check
#   install_deps NAME pac aur proxy  # the last three are array names
#

# Same directory as the scripts that source this file.
CURRENT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
SCRIPT_BINS="$(dirname -- "$CURRENT_DIR")/bin"

# SCRIPT_NAME and ensure_command
. "$(dirname -- "$CURRENT_DIR")/lib/bash.sh"

# deps_init ARG... - check the args, set up PATH, check the tools and the distro
deps_init() {
  # --help and unknown options: usage() comes from the caller
  local arg
  for arg in "$@"; do
    case $arg in
      -h | --help)
        usage
        exit 0
        ;;
      *)
        echo "$SCRIPT_NAME: unknown option: $arg" >&2
        usage >&2
        exit 2
        ;;
    esac
  done

  # the scripts below, and the tools in bin/, are called by name
  PATH="$CURRENT_DIR:$PATH"
  if [[ ! -d $SCRIPT_BINS ]]; then
    echo "$SCRIPT_NAME: error: $SCRIPT_BINS missing" >&2
    exit 1
  fi
  PATH="$SCRIPT_BINS:$PATH"

  ensure_command "$CURRENT_DIR/is_archlinux"
  ensure_command "$CURRENT_DIR/ensure-archlinuxcn"
  ensure_command "$SCRIPT_BINS/proxy_ok"

  if ! is_archlinux; then
    echo "$SCRIPT_NAME: error: This script only support archlinux!" >&2
    exit 1
  fi
}

# deps_section TITLE - banner before one group of packages
deps_section() {
  echo ""
  echo "====== $1 ======"
  echo ""
}

# install_deps NAME PAC AUR AUR_PROXY - install the three package lists
# The last three arguments are the names of arrays in the caller.
install_deps() {
  local name=$1
  local -n pac=$2 aur=$3 proxy=$4

  deps_section "$name: pacman"
  if [[ ${#pac[@]} -eq 0 ]]; then
    echo "No dependencies. SKIPPED."
  else
    echo "[Running] sudo pacman -S --needed ${pac[*]}"
    echo ""
    sudo pacman -S --needed "${pac[@]}"
  fi

  deps_section "$name: AUR"
  if [[ ${#aur[@]} -eq 0 ]]; then
    echo "No dependencies. SKIPPED."
  else
    echo "[Running] paru -S --needed ${aur[*]}"
    echo ""
    paru -S --needed "${aur[@]}"
  fi

  # packages behind a proxy are skipped when the proxy is not working
  deps_section "$name: AUR (proxy needed)"
  if [[ ${#proxy[@]} -eq 0 ]]; then
    echo "No dependencies. SKIPPED."
  elif ! proxy_ok; then
    echo "$SCRIPT_NAME: Warning: proxy is not working. SKIPPED."
  else
    echo "[Running] paru -S --needed ${proxy[*]}"
    echo ""
    paru -S --needed "${proxy[@]}"
  fi

  echo "Done."
}
