#!/usr/bin/env bash
#
# paths.sh -- Add paths to $env:PATH
#

CURRENT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)

source "$CURRENT_DIR/functions.sh"

# skip if loaded
if [[ -n ${__PATHS_SH_LOADED:-} ]]; then
  return 0
fi
readonly __PATHS_SH_LOADED=1

# ==========================================
# Set Paths
# ==========================================

# add `~/.local/bin` to PATH
LOCAL_BINS="$HOME/.local/bin"
[ -d $LOCAL_BINS ] && prepend_path "$LOCAL_BINS"

# add custom executables to PATH: ./scripts/bin/
SCRIPT_BINS="$CURRENT_DIR/scripts/bin"
[ -d $SCRIPT_BINS ] && prepend_path $SCRIPT_BINS || echo "warning: $SCRIPT_BINS not exists"

# add custom rust-related commands
RUST_SCRIPTS_BIN="$HOME/.config/rust/scripts/bin"
[ -d $RUST_SCRIPTS_BIN ] && prepend_path $RUST_SCRIPTS_BIN || echo "warning: $RUST_SCRIPTS_BIN not exists!"

#
# OS specific
#---------------------------------

# archlinux specific: ./scripts/archbin/
ARCHBINS="$CURRENT_DIR/scripts/archbin"
$ARCHBINS/is_archlinux && prepend_path $ARCHBINS
