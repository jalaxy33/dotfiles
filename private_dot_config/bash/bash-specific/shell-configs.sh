#!/usr/bin/env bash
#
# shell-configs.sh -- bash specific configs
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# prompt format
PS1='[\u@\h \W]\$ '

# auto cd
shopt -s autocd

# line wrap on window resize
shopt -s checkwinsize

# history related settings
# ignore duplicate lines and lines starting with a space
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

HISTSIZE=50
HISTFILESIZE=100

# history shows a timestamp
HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S  "
