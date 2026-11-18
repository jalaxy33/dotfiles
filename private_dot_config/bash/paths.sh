#!/usr/bin/env bash
#
# paths.sh -- add directories to PATH
#

[[ -n ${__PATHS_SH_LOADED:-} ]] && return 0
readonly __PATHS_SH_LOADED=1

# directory of this file
[[ -n ${__CONFIG_DIR:-} ]] ||
  __CONFIG_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}")" && pwd -P)

# ==========================================
# OS Probe
# ==========================================

__IS_ARCH=false
"$__CONFIG_DIR/scripts/archbin/is_archlinux" && __IS_ARCH=true

# ==========================================
# Set Paths
# ==========================================

# First entry wins; missing directories are skipped.
__paths=(
  # custom rust-related commands
  "$HOME/.config/rust/scripts/bin"

  # our own commands: clear_pi, rm_except, ...
  "$__CONFIG_DIR/scripts/bin"

  # user-installed commands
  "$HOME/.local/bin"

  # homebrew
  "/home/linuxbrew/.linuxbrew/bin"
)

# archlinux only: is_archlinux, ensure-*
[[ $__IS_ARCH == true ]] && __paths+=("$__CONFIG_DIR/scripts/archbin")

# scripts/bin is not on PATH yet, so use the full path here
eval "$("$__CONFIG_DIR/scripts/bin/prepend_path" "${__paths[@]}")"
