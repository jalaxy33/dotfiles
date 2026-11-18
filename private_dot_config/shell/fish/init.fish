# init.fish -- fish initialization

if status is-interactive
    set fish_greeting ""
end

#======================================
# fish settings
#======================================

set -l __SHELL_DIR $HOME/.config/shell

source $__SHELL_DIR/fish/paths.fish
source $__SHELL_DIR/fish/env.fish
source $__SHELL_DIR/fish/languages.fish
source $__SHELL_DIR/fish/aliases.fish

#======================================
# apps
#======================================

command -q brew && eval (brew shellenv)
command -q starship && starship init fish | source
command -q zoxide && zoxide init fish --cmd cd | source
command -q fzf && fzf --fish | source
command -q jj && jj util completion fish | source
