#!/usr/bin/env bash
#
# init.sh -- bash initialization
#

# nothing to do in non-interactive shells
[[ $- != *i* ]] && return

# shared configs: paths first, it sets up PATH for the rest
source "$HOME/.config/shell/posix/paths.sh"
source "$HOME/.config/shell/posix/env.sh"
source "$HOME/.config/shell/posix/languages.sh"
source "$HOME/.config/shell/posix/aliases.sh"

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
HISTSIZE=50
HISTFILESIZE=100
HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S  "

#======================================
# apps
#======================================

command -v brew >/dev/null && eval "$(brew shellenv)"
command -v starship >/dev/null && eval "$(starship init bash)"
command -v zoxide >/dev/null && eval "$(zoxide init bash --cmd cd)"
command -v fzf >/dev/null && eval "$(fzf --bash)"
command -v jj >/dev/null && source <(jj util completion bash)

#======================================
# bash apps
#======================================

source "$HOME/.config/shell/bash/bash-apps.sh"

# bash-completion
activate_bash_completion

# fish-like interactive behavior
# activate_flyline
