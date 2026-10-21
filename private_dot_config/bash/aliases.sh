#!/usr/bin/env bash
#
# aliases.sh -- command aliases
#

case ${ZSH_VERSION-} in
  '') _src=${BASH_SOURCE:-$0} ;;   # bash
  *)  _src=${(%):-%x} ;;           # zsh
esac
CURRENT_DIR=$(cd -- "$(dirname -- "$_src")" && pwd -P)
unset _src

source "$CURRENT_DIR/functions.sh"
source "$CURRENT_DIR/paths.sh"

# skip if loaded
if [[ -n ${__ALIASES_SH_LOADED:-} ]]; then
  return 0
fi
readonly __ALIASES_SH_LOADED=1

# ==========================================
# system commands
# ==========================================

# color support
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

# ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# ==========================================
# aliases & abbrs
# ==========================================

# editor aliases
alias vi="vim"
alias nv="nvim"

# command abbrs
alias fa="fastfetch"
alias grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'

command_exists lazygit && alias lg="lazygit"
command_exists lazyjj && alias lj="lazyjj"

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
if command_exists rsync; then
  alias rsyncp="rsync -alvhP"
fi

# task
if command_exists go-task && ! command_exists task; then
  alias task="go-task"
fi

# zed
if command_exists zeditor && ! command_exists zed; then
  alias zed='zeditor --classic'
fi

# helix
if command_exists helix && ! command_exists hx; then
  alias hx="helix"
fi

# chezmoi for niri dotfiles
if command_exists chezmoi; then
  alias nirichezmoi="chezmoi -S $HOME/.local/share/chezmoi-niri/"
fi

# lazygit

# lazyjj
command_exists lazyjj && alias lj="lazyjj"

# ==========================================
# alias functions
# ==========================================

function ls() {
  command_exists eza && eza --icons --git -a -g "$@"
}

y() {
  command_exists yazi || return 1
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd <"$tmp"
  [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}
