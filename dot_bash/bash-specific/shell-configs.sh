# bash-configs.sh -- bash specific configs

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# prompt format
PS1='[\u@\h \W]\$ '

# auto cd
shopt -s autocd

# line wrap on window resize
shopt -s checkwinsize

# history related settings
## ignore duplicate lines and space in the history.
HISTCONTROL=ignoredups:ignorespace

## append to the history file, don't overwrite it
shopt -s histappend

## for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=50
HISTFILESIZE=100

## history show timestamp
HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S  "
