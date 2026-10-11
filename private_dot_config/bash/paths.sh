#!/usr/bin/env bash
#
# paths.sh -- Add paths to $env:PATH
#

source "$HOME/.config/bash/functions.sh"

# skip if loaded
if [[ -n ${__PATHS_SH_LOADED:-} ]]; then
  return 0
fi
readonly __PATHS_SH_LOADED=1

# ==========================================
# Set Paths
# ==========================================

# Add `~/.local/bin` to PATH
prepend_path "$HOME/.local/bin"

# Add custom executable scripts to PATH: `~/.local/bin/scripts/`
SCRIPTS_DIR="$HOME/.local/bin/scripts"
[ -d $SCIRPTS_DIR ] && prepend_path $SCRIPTS_DIR || echo "Warning: $SCIRPTS_DIR not exists!"

# archlinux specific
is_archlinux && prepend_path "$HOME/.local/bin/archbin"
