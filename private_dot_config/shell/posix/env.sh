#!/usr/bin/env bash
#
# env.sh -- environment variables
#

[[ -n ${__ENV_SH_LOADED:-} ]] && return 0
readonly __ENV_SH_LOADED=1

#======================================
# apps
#======================================

# manpage using $EDITOR, when it is a vim-like editor
if [[ -n $EDITOR && ($EDITOR == *vim* || $EDITOR == *nv*) ]]; then
  export MANPAGER="sh -c '$EDITOR +Man!'"
fi

#======================================
# mirrors
#======================================

# one file for both shells, so the lists cannot drift
eval "$(load_dotenv "$(dirname -- "${BASH_SOURCE[0]:-$0}")/../mirrors.env")"

#======================================
# .env
#======================================

# load ~/.env, silently when there is none
if [[ -f ~/.env ]]; then
  eval "$(load_dotenv)"
fi
