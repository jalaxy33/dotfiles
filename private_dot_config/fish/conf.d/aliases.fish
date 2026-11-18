# ~/.config/fish/conf.d/aliases.fish
#
# Command aliases
#

# so the `command -q` checks below see the full PATH
source "$HOME/.config/fish/conf.d/paths.fish"

# ==========================================
# aliases & abbrs
# ==========================================

# editor aliases
alias vi='vim'
alias nv='nvim'

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

# configs shortcuts
set BASH_CONFIG "$HOME/.bashrc"
alias vibash="vi $BASH_CONFIG"
alias nvbash="nv $BASH_CONFIG"
alias hxbash="hx $BASH_CONFIG"
alias catbash="cat $BASH_CONFIG"
alias batbash="bat $BASH_CONFIG"

set ZSH_CONFIG "$HOME/.zshrc"
alias vizsh="vi $ZSH_CONFIG"
alias nvzsh="nv $ZSH_CONFIG"
alias hxzsh="hx $ZSH_CONFIG"
alias catzsh="cat $ZSH_CONFIG"
alias batzsh="bat $ZSH_CONFIG"

set FISH_CONFIG "$HOME/.config/fish/config.fish"
alias vifish="vi $FISH_CONFIG"
alias nvfish="nv $FISH_CONFIG"
alias hxfish="hx $FISH_CONFIG"
alias catfish="cat $FISH_CONFIG"
alias batfish="bat $FISH_CONFIG"


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
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end
