#!/usr/bin/env bash
#
# languages.sh -- languages related settings
#

# rust
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# npm
if [ -d "$HOME/.npm-global/bin" ]; then
  prepend_path "$HOME/.npm-global/bin"
fi

# pnpm
if [ -d "$HOME/.local/share/pnpm" ]; then
  export PNPM_HOME="$HOME/.local/share/pnpm"
  prepend_path "$PNPM_HOME"
fi

# bun
if [ -d "$HOME/.bun/bin" ]; then
  export BUN_BIN_DIR="$HOME/.bun/bin"
  prepend_path "$BUN_BIN_DIR"
fi

# haskell
[ -d "$HOME/.ghcup/bin" ] && prepend_path "$HOME/.ghcup/bin"
[ -d "$HOME/.cabal/bin" ] && prepend_path "$HOME/.cabal/bin"
