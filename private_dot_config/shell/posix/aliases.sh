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

# vibash/nvbash/hxbash/catbash/batbash open the config of NAME
_alias_config() {
  local __name=$1 __file=$2
  alias "vi$__name=vi $__file" "nv$__name=nv $__file" "hx$__name=hx $__file" \
    "cat$__name=cat $__file" "bat$__name=bat $__file"
}

_alias_config bash "$HOME/.bashrc"
_alias_config zsh "$HOME/.zshrc"
_alias_config fish "$HOME/.config/fish/config.fish"

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

# chezmoi
if command -v chezmoi >/dev/null 2>&1; then
  alias cz="chezmoi"

  # chezmoi for niri dotfiles
  alias niricz="chezmoi -S $HOME/.local/share/chezmoi-niri/"
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
  local __tmp="$(mktemp -t "yazi-cwd.XXXXXX")" __cwd
  command yazi "$@" --cwd-file="$__tmp"
  IFS= read -r -d '' __cwd <"$__tmp"
  [ "$__cwd" != "$PWD" ] && [ -d "$__cwd" ] && builtin cd -- "$__cwd"
  rm -f -- "$__tmp"
}

# ==========================================
# clean
# ==========================================

unset -f _alias_config
