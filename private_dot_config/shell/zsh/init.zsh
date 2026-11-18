#!/usr/bin/env zsh
#
# init.zsh -- zsh initialization
#

#======================================
# shared configs
#======================================

__SHELL_DIR="$HOME/.config/shell"

source "$__SHELL_DIR/posix/paths.sh"
source "$__SHELL_DIR/posix/env.sh"
source "$__SHELL_DIR/posix/languages.sh"
source "$__SHELL_DIR/posix/aliases.sh"

#======================================
# zsh settings
#======================================

source "$__SHELL_DIR/zsh/keybinds.zsh"
source "$__SHELL_DIR/zsh/aliases.zsh"

#======================================
# apps
#======================================

# homebrew
command -v brew >/dev/null && eval "$(brew shellenv)"

#---------------------
# better prompt
#---------------------
# zimfw or starship; environment: ZSH_PROMPT=starship
ZSH_PROMPT=${ZSH_PROMPT:-zimfw}
[[ $ZSH_PROMPT == zimfw || $ZSH_PROMPT == starship ]] ||
  echo "init.zsh: unknown ZSH_PROMPT '$ZSH_PROMPT', using starship" >&2

# zimfw brings compinit and the prompt; without it, compinit + starship
if [[ $ZSH_PROMPT != zimfw ]] || ! source "$__SHELL_DIR/zsh/zimfw.zsh"; then
  autoload -Uz compinit && compinit
  command -v starship >/dev/null && eval "$(starship init zsh)"
fi

#----------------------
# other apps
#----------------------
command -v zoxide >/dev/null && eval "$(zoxide init zsh --cmd cd)"
command -v fzf >/dev/null && source <(fzf --zsh)
command -v jj >/dev/null && source <(jj util completion zsh)

#======================================
# clean
#======================================

unset ZSH_PROMPT __SHELL_DIR
