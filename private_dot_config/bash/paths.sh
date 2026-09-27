#!/usr/bin/env bash
#
# paths.sh -- Add paths to $env:PATH
#

source "$HOME/.config/bash/functions.sh"

# Add `~/.local/bin` to PATH
prepend_path "$HOME/.local/bin"

# Add custom executable scripts to PATH: `~/.local/bin/scripts/`
SCRIPTS_DIR="$HOME/.local/bin/scripts"
[ -d $SCIRPTS_DIR ] && prepend_path $SCRIPTS_DIR || echo "Warning: $SCIRPTS_DIR not exists!"

# archlinux specific
is_archlinux && prepend_path "$HOME/.local/bin/archbin"
