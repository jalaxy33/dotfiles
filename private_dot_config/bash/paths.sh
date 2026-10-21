#!/usr/bin/env bash
#
# paths.sh -- Add paths to $env:PATH
#

# skip if loaded
[[ -n ${__PATHS_SH_LOADED:-} ]] && return 0
readonly __PATHS_SH_LOADED=1

# import helpers
case ${ZSH_VERSION-} in
  '') _src=${BASH_SOURCE:-$0} ;;   # bash
  *)  _src=${(%):-%x} ;;           # zsh
esac
CURRENT_DIR=$(cd -- "$(dirname -- "$_src")" && pwd -P)
unset _src

source "$CURRENT_DIR/functions.sh"

# ==========================================
# Set Paths
# ==========================================

# add homebrew to PATH
prepend_path "/home/linuxbrew/.linuxbrew/bin"

# add `~/.local/bin` to PATH
prepend_path "$HOME/.local/bin"

# add custom executables to PATH: ./scripts/bin/
SCRIPT_BINS="$CURRENT_DIR/scripts/bin"
prepend_path $SCRIPT_BINS || echo "warning: $SCRIPT_BINS not exists"

# add custom rust-related commands
RUST_SCRIPTS_BIN="$HOME/.config/rust/scripts/bin"
prepend_path $RUST_SCRIPTS_BIN || echo "warning: $RUST_SCRIPTS_BIN not exists!"

#
# OS specific
#---------------------------------

# archlinux specific: ./scripts/archbin/
ARCHBINS="$CURRENT_DIR/scripts/archbin"
$ARCHBINS/is_archlinux && prepend_path $ARCHBINS
