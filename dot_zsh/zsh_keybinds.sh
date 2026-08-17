# ~/.zsh/zsh_keybinds.sh

#
# Set lazygit keybinding (crtl+g)
#
function lazygit_widget() {
  lazygit
  zle reset-prompt
}

zle -N lazygit_widget
bindkey '^g' lazygit_widget

#
# Set yazi keybinding (crtl+y)
#
function yazi_widget() {
  y
  zle reset-prompt
}

zle -N yazi_widget
bindkey '^y' yazi_widget

#
# Set nvim keybinding (alt+n)
#
function nvim_widget() {
  nvim
  zle reset-prompt
}

zle -N nvim_widget
bindkey '^[n' nvim_widget
