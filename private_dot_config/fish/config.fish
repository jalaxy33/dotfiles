# ~/.config/fish/config.fish
#
# ## File Structure
# ~/.config/fish/
# ├── conf.d/     # dir for auto-loaded configs
# ├── functions/  # dir for functions
# └── config.fish
#
# ## Softwares
# Necessary:
#  - fish, starship, vim(or gvim)
#  - zoxide, fzf, eza, yazi, jq, ripgrep, fd
#
# Optional but useful:
#  - bat, helix, rsync, neovim, fastfetch, lazygit

if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting ""
end

#
#-- Imports
#
# Add `~/.bash/bin/` to PATH, which contains custom commands
set SCIRPTS_DIR "$HOME/.bash/bin/"
test -d $SCIRPTS_DIR && prepend_path "$SCIRPTS_DIR" || echo "Warning: $SCIRPTS_DIR not exists!"

# add `~/.local/bin` to PATH
set LOCAL_BIN_DIR "$HOME/.local/bin"
test -d $LOCAL_BIN_DIR && prepend_path $LOCAL_BIN_DIR

# load ~/.env
test -e ~/.env && load_dotenv

#
#-- try to activate homebrew
#
set BREW_PREFIX "/home/linuxbrew/.linuxbrew"
set BREW_CMD "$BREW_PREFIX/bin/brew"
command -q $BREW_CMD && eval ($BREW_CMD shellenv)

#
#-- Init apps
#
command -q starship && starship init fish | source
command -q zoxide && zoxide init fish --cmd cd | source
command -q fzf && fzf --fish | source

# config yazi
function y
    command -q yazi || return 1
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# jujutsu completion
command -q jj && COMPLETE=fish jj | source

#
#-- Language
#
# rust
test -f "$HOME/.cargo/env.fish" && source "$HOME/.cargo/env.fish"

# npm
if test -d "$HOME/.npm-global/bin"
  prepend_path "$HOME/.npm-global/bin"
end

# pnpm
if test -d "$HOME/.local/share/pnpm"
    set -gx PNPM_HOME "$HOME/.local/share/pnpm"
    prepend_path $PNPM_HOME
end

# bun
if test -d "$HOME/.bun/bin"
    set -gx BUN_BIN_DIR "$HOME/.bun/bin"
    prepend_path $BUN_BIN_DIR
end

# haskell
test -d "$HOME/.ghcup/bin" && prepend_path "$HOME/.ghcup/bin" 
test -d "$HOME/.cabal/bin" && prepend_path "$HOME/.cabal/bin"
