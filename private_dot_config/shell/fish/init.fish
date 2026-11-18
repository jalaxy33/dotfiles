# init.fish -- fish initialization

set -g __CONFIG_DIR "$HOME/.config/shell"

if status is-interactive
    set fish_greeting ""
end

# shared configs: paths first, it sets up PATH for the rest
source $__CONFIG_DIR/fish/paths.fish
source $__CONFIG_DIR/fish/env.fish
source $__CONFIG_DIR/fish/languages.fish
source $__CONFIG_DIR/fish/aliases.fish

#======================================
# apps
#======================================

command -q brew && eval (brew shellenv)
command -q starship && starship init fish | source
command -q zoxide && zoxide init fish --cmd cd | source
command -q fzf && fzf --fish | source
command -q jj && jj util completion fish | source
