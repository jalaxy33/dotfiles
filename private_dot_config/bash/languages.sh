#!/usr/bin/env bash
#
# languages.sh -- languages related settings
#

source "$HOME/.config/bash/functions.sh"

# rust
try_source "$HOME/.cargo/env"

# npm
prepend_path "$HOME/.npm-global/bin"

# pnpm
PNPM_HOME="$HOME/.local/share/pnpm"
[ -d $PNPM_HOME ] && export PNPM_HOME=$PNPM_HOME && prepend_path $PNPM_HOME

# bun
BUN_BIN_DIR="$HOME/.bun/bin"
[ -d $BUN_BIN_DIR ] && export BUN_BIN_DIR=$BUN_BIN_DIR && prepend_path $BUN_BIN_DIR

# haskell
prepend_path "$HOME/.ghcup/bin"
prepend_path "$HOME/.cabal/bin"
