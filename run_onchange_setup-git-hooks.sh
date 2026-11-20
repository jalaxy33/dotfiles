#!/bin/sh
#
# run_onchange_setup-git-hooks.sh -- point the dotfiles repo at the managed hooks.
#
# A run script rather than a chezmoi hook: the config that carries hooks is
# written during apply, so on a fresh machine it would only take effect on the
# next apply.
#
git -C "$CHEZMOI_SOURCE_DIR" config core.hooksPath "$HOME/.config/git/hooks"
