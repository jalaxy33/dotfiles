#!/usr/bin/env zsh
#
# zimfw.zsh -- zimfw setup: which script to use, activation
#
# Exit status: 0 when zimfw got loaded, 1 when it is not installed.

#======================================
# functions
#======================================

activate_zimfw() {
  local __script="" __candidate __zim_home __zimrc
  __zim_home=${ZDOTDIR:-${HOME}}/.zim
  __zimrc=${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc}

  # homebrew zimfw first, then the system one
  for __candidate in \
    "/home/linuxbrew/.linuxbrew/opt/zimfw/share/zimfw.zsh" \
    "/usr/share/zimfw/zimfw.zsh"; do
    if [[ -f $__candidate ]]; then
      __script=$__candidate
      break
    fi
  done
  [[ -n $__script ]] || return

  [[ -f $__zimrc ]] || echo "Warning: $__zimrc not exist!"

  # install missing modules and update ${zim_home}/init.zsh when outdated
  if [[ ! ${__zim_home}/init.zsh -nt $__zimrc ]]; then
    source "$__script" init
  fi

  # initialize modules
  source "${__zim_home}/init.zsh"

  # modules configuration
  ZSH_AUTOSUGGEST_MANUAL_REBIND=1
}

#======================================
# activation
#======================================

activate_zimfw

#======================================
# clean
#======================================

unset -f activate_zimfw

# 0 when zimfw is loaded, so init.zsh can fall back to starship
whence -w zimfw &>/dev/null
