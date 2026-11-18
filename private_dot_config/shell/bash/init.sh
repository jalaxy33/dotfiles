#!/usr/bin/env bash
#
# init.sh -- bash initialization
#

# nothing to do in non-interactive shells
[[ $- != *i* ]] && return

#======================================
# shared configs
#======================================

__SHELL_DIR="$HOME/.config/shell"

source "$__SHELL_DIR/posix/paths.sh"
source "$__SHELL_DIR/posix/env.sh"
source "$__SHELL_DIR/posix/languages.sh"
source "$__SHELL_DIR/posix/aliases.sh"

#======================================
# bash settings
#======================================

# prompt format
PS1='[\u@\h \W]\$ '

# auto cd on a bare directory name
shopt -s autocd

# line wrap on window resize
shopt -s checkwinsize

# history: ignore duplicates and lines starting with a space, append, timestamp
HISTCONTROL=ignoredups:ignorespace
shopt -s histappend
HISTSIZE=10000
HISTFILESIZE=20000
HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S  "

#======================================
# apps
#======================================

command -v brew >/dev/null && eval "$(brew shellenv)"
command -v starship >/dev/null && eval "$(starship init bash)"
command -v zoxide >/dev/null && eval "$(zoxide init bash --cmd cd)"
command -v fzf >/dev/null && eval "$(fzf --bash)"
command -v jj >/dev/null && source <(jj util completion bash)

# bash-specific tools
source "$__SHELL_DIR/bash/activate.sh"

#======================================
# clean
#======================================

unset __SHELL_DIR
