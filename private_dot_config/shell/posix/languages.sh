#!/usr/bin/env bash
#
# languages.sh -- languages related settings
#

[[ -n ${__LANGUAGES_SH_LOADED:-} ]] && return 0
readonly __LANGUAGES_SH_LOADED=1

# ==========================================
# Language Setup
# ==========================================

# rustup's own file: puts ~/.cargo/bin in PATH
[[ -f $HOME/.cargo/env ]] && source "$HOME/.cargo/env"

# pnpm and bun want these exported, but only when they are installed
PNPM_HOME="$HOME/.local/share/pnpm"
[[ -d $PNPM_HOME ]] && export PNPM_HOME

BUN_BIN_DIR="$HOME/.bun/bin"
[[ -d $BUN_BIN_DIR ]] && export BUN_BIN_DIR

# First entry wins; missing directories are skipped.
__paths=(
  # cabal first: ghcup may ship its own copy
  "$HOME/.cabal/bin"

  # ghcup
  "$HOME/.ghcup/bin"

  # bun
  "$BUN_BIN_DIR"

  # pnpm
  "$PNPM_HOME"

  # npm
  "$HOME/.npm-global/bin"
)

eval "$(prepend_path "${__paths[@]}")"
