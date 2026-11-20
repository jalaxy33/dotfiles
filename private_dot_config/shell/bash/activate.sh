#!/usr/bin/env bash
#
# activate.sh -- activate bash-specific tools
#

__BREW_PREFIX="/home/linuxbrew/.linuxbrew"

# _find_first PATH... - print the first path that exists as a file
_find_first() {
  local __path
  for path in "$@"; do
    [[ -f $path ]] || continue
    printf '%s\n' "$path"
    return 0
  done
  return 1
}

# Initialize bash-completion, preferring system-installed version.
activate_bash_completion() {
  # Only run in interactive shells and avoid reloading.
  [[ -z $PS1 || -n ${BASH_COMPLETION_VERSINFO:-} ]] && return

  # candidate paths, system first
  local __path
  __path=$(_find_first \
    "/usr/share/bash-completion/bash_completion" \
    "$__BREW_PREFIX/etc/profile.d/bash_completion.sh") || return

  source "$__path"
}

# fish-like interactive behavior
activate_flyline() {
  # candidate paths, system first
  local __path
  __path=$(_find_first \
    "/usr/lib/bash/libflyline.so" \
    "$__BREW_PREFIX/lib/bash/flyline") || return

  enable -f "$__path" flyline
}

#======================================
# optional features
#======================================

# bash-completion
activate_bash_completion

# fish-like interactive behavior
# set NO_FLYLINE=1 to skip it
[[ -n $NO_FLYLINE ]] || activate_flyline

#======================================
# clean
#======================================

unset -f activate_bash_completion activate_flyline _find_first
unset __BREW_PREFIX
