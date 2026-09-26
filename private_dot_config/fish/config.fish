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


# try to activate homebrew (if installed)
set BREW_CMD "/home/linuxbrew/.linuxbrew/bin/brew"
command -q $BREW_CMD && eval ($BREW_CMD shellenv)


# init apps
command -q starship && starship init fish | source
command -q zoxide && zoxide init fish --cmd cd | source
command -q fzf && fzf --fish | source

