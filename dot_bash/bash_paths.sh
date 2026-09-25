#!/usr/bin/env bash
#
# bash_paths.sh -- Add paths to $env:PATH
#

source "$HOME/.bash/bash_functions.sh"

# Add `~/.bash/bin/` to PATH, which contains custom commands
SCRIPTS_DIR="$HOME/.bash/bin/"
[ -d $SCRIPTS_DIR ] && prepend_path $SCRIPTS_DIR || echo "Warning: $SCIRPTS_DIR not exists!"

# Add `~/.local/bin` to PATH
LOCAL_BIN_DIR="$HOME/.local/bin"
[ -d $LOCAL_BIN_DIR ] && prepend_path $LOCAL_BIN_DIR

# archlinux specific
ARCH_BIN_DIR="$HOME/.local/bin/archbin"
[[ -d $ARCH_BIN_DIR && is_archlinux ]] && prepend_path $ARCH_BIN_DIR
