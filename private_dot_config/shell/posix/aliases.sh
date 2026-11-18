#!/usr/bin/env bash
#
# aliases.sh -- command aliases
#

[[ -n ${__ALIASES_SH_LOADED:-} ]] && return 0
readonly __ALIASES_SH_LOADED=1

# ==========================================
# system commands
# ==========================================

# color support (ls is a function below)
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

# ls aliases (no -F/-C: eza does not accept them)
alias ll='ls -l'
alias la='ls -A'
alias l='ls'

# ==========================================
# aliases & abbrs
# ==========================================

# editor aliases
alias vi="vim"
alias nv="nvim"

# command abbrs
alias fa="fastfetch"
alias grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'

# reboot/poweroff
alias reboot="sudo systemctl reboot"
alias poweroff="sudo systemctl poweroff"

# configs shortcuts
BASH_CONFIG="$HOME/.bashrc"
alias vibash="vi $BASH_CONFIG"
alias nvbash="nv $BASH_CONFIG"
alias hxbash="hx $BASH_CONFIG"
alias catbash="cat $BASH_CONFIG"
alias batbash="bat $BASH_CONFIG"

ZSH_CONFIG="$HOME/.zshrc"
alias vizsh="vi $ZSH_CONFIG"
alias nvzsh="nv $ZSH_CONFIG"
alias hxzsh="hx $ZSH_CONFIG"
alias catzsh="cat $ZSH_CONFIG"
alias batzsh="bat $ZSH_CONFIG"

FISH_CONFIG="$HOME/.config/fish/config.fish"
alias vifish="vi $FISH_CONFIG"
alias nvfish="nv $FISH_CONFIG"
alias hxfish="hx $FISH_CONFIG"
alias catfish="cat $FISH_CONFIG"
alias batfish="bat $FISH_CONFIG"

# ==========================================
# command aliases
# ==========================================

# shortcuts for rsync
if command -v rsync >/dev/null 2>&1; then
  alias rsyncp="rsync -alvhP"
fi

# task
if command -v go-task >/dev/null 2>&1 && ! command -v task >/dev/null 2>&1; then
  alias task="go-task"
fi

# zed
if command -v zeditor >/dev/null 2>&1 && ! command -v zed >/dev/null 2>&1; then
  alias zed='zeditor --classic'
fi

# helix
if command -v helix >/dev/null 2>&1 && ! command -v hx >/dev/null 2>&1; then
  alias hx="helix"
fi

# chezmoi for niri dotfiles
if command -v chezmoi >/dev/null 2>&1; then
  alias nirichezmoi="chezmoi -S $HOME/.local/share/chezmoi-niri/"
fi

# lazygit & lazyjj
command -v lazygit >/dev/null 2>&1 && alias lg="lazygit"
command -v lazyjj >/dev/null 2>&1 && alias lj="lazyjj"

# ==========================================
# alias functions
# ==========================================

ls() {
  if command -v eza >/dev/null 2>&1; then
    # --icons=auto, not --icons: the bare form would eat a following path
    eza --icons=auto --git -a -g "$@"
  else
    command ls --color=auto "$@"
  fi
}

y() {
  command -v yazi >/dev/null 2>&1 || return 1
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd <"$tmp"
  [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}
