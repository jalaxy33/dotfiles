# aliases.fish -- command aliases

# ==========================================
# aliases & abbrs
# ==========================================

# editor aliases
alias vi='vim'
alias nv='nvim'

# ls shortcuts (ls is a function below)
alias ll 'ls -l'
alias la 'ls -A'
alias l 'ls'

# command abbrs
abbr fa fastfetch
abbr grub 'sudo grub-mkconfig -o /boot/grub/grub.cfg'

command -q lazygit && abbr lg lazygit
command -q lazyjj && abbr lj lazyjj

# reboot/poweroff
abbr reboot "sudo systemctl reboot"
abbr poweroff "sudo systemctl poweroff"

# history with timestamp
abbr history 'history --show-time="%Y-%m-%d %H:%M:%S "'

# vibash/nvbash/hxbash/catbash/batbash open the config of NAME
function _alias_config --argument-names __name __file
    for tool in vi nv hx cat bat
        alias "$tool$__name=$tool $__file"
    end
end

_alias_config bash $HOME/.bashrc
_alias_config zsh $HOME/.zshrc
_alias_config fish $HOME/.config/fish/config.fish


# ==========================================
# command aliases
# ==========================================

# shortcuts for rsync
if command -q rsync
    alias rsyncp="rsync -alvhP"
end

# task
if command -q go-task; and not command -q task
    alias task='go-task'
end

# zed
if command -q zeditor; and not command -q zed
    alias zed='zeditor --classic'
end

# helix
if command -q helix; and not command -q hx
    alias hx="helix"
end

# chezmoi for niri dotfiles
if command -q chezmoi
    alias nirichezmoi="chezmoi -S ~/.local/share/chezmoi-niri/"
end


# ==========================================
# alias functions
# ==========================================

function ls
    if command -q eza
        # --icons=auto, not --icons: the bare form would eat a following path
        command eza --icons=auto --git -a -g $argv
    else
        command ls --color=auto $argv
    end
end

function y
    command -q yazi || return 1
    set __tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$__tmp"
    if read -z __cwd <"$__tmp"; and [ "$__cwd" != "$PWD" ]; and test -d "$__cwd"
        builtin cd -- "$__cwd"
    end
    rm -f -- "$__tmp"
end

# ==========================================
# clean
# ==========================================

functions -e _alias_config
