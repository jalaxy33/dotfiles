#!/usr/bin/env bash
#
# languages.sh -- languages related settings
#

case ${ZSH_VERSION-} in
  '') _src=${BASH_SOURCE:-$0} ;;   # bash
  *)  _src=${(%):-%x} ;;           # zsh
esac
CURRENT_DIR=$(cd -- "$(dirname -- "$_src")" && pwd -P)
unset _src

source "$CURRENT_DIR/functions.sh"

# skip if loaded
if [[ -n ${__LANGUAGES_SH_LOADED:-} ]]; then
  return 0
fi
readonly __LANGUAGES_SH_LOADED=1

# ==========================================
# Language Setup
# ==========================================

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
