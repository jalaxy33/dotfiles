#!/usr/bin/env zsh
#
# init.zsh -- zsh initialization
#

# shared configs: paths first, it sets up PATH for the rest
source "$HOME/.config/shell/posix/paths.sh"
source "$HOME/.config/shell/posix/env.sh"
source "$HOME/.config/shell/posix/languages.sh"
source "$HOME/.config/shell/posix/aliases.sh"

#======================================
# zsh settings
#======================================

source "$HOME/.config/shell/zsh/zimfw.zsh"
source "$HOME/.config/shell/zsh/keybinds.zsh"
source "$HOME/.config/shell/zsh/aliases.zsh"

#======================================
# apps
#======================================

command -v brew >/dev/null && eval "$(brew shellenv)"

# zimfw, or compinit + starship when zimfw is not in use
activate_zimfw

if ! is_zimfw_loaded; then
  # fix: command not found: compdef
  autoload -Uz compinit && compinit

  command -v starship >/dev/null && eval "$(starship init zsh)"
fi

command -v zoxide >/dev/null && eval "$(zoxide init zsh --cmd cd)"
command -v fzf >/dev/null && source <(fzf --zsh)
command -v jj >/dev/null && source <(jj util completion zsh)
