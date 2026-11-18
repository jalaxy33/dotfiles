#!/usr/bin/env bash
#
# paths.sh -- add directories to PATH
#

[[ -n ${__PATHS_SH_LOADED:-} ]] && return 0
readonly __PATHS_SH_LOADED=1

# root of the shell configs: reused when the caller already set it
__SHELL_DIR=${__SHELL_DIR:-$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}")/.." && pwd -P)}

# ==========================================
# OS Probe
# ==========================================

__IS_ARCH=false
"$__SHELL_DIR/scripts/archbin/is_archlinux" && __IS_ARCH=true

# ==========================================
# Set Paths
# ==========================================

# First entry wins; missing directories are skipped.
__paths=(
  # custom rust-related commands
  "$HOME/.config/rust/scripts/bin"

  # our own commands: clear_pi, rm_except, ...
  "$__SHELL_DIR/scripts/bin"

  # user-installed commands
  "$HOME/.local/bin"

  # homebrew
  "/home/linuxbrew/.linuxbrew/bin"
)

# archlinux only: is_archlinux, ensure-*
[[ $__IS_ARCH == true ]] && __paths+=("$__SHELL_DIR/scripts/archbin")

# scripts/bin is not on PATH yet, so use the full path here
eval "$("$__SHELL_DIR/scripts/bin/prepend_path" "${__paths[@]}")"

# ==========================================
# Libraries
# ==========================================

# libtorch, archlinux only
if [[ $__IS_ARCH == true && -d /opt/libtorch ]]; then
  export LIBTORCH="/opt/libtorch"
  export LD_LIBRARY_PATH="$LIBTORCH/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
  export LIBTORCH_BYPASS_VERSION_CHECK="1"
fi

# ==========================================
# clean
# ==========================================

unset __paths __IS_ARCH
