# paths.fish -- Add paths to $env:PATH

set BASH_SCRIPTS "$HOME/.config/bash/scripts"

# ==========================================
# Set Paths
# ==========================================

# add homebrew to PATH
prepend_path "/home/linuxbrew/.linuxbrew/bin"

# add `~/.local/bin/` to PATH
prepend_path "$HOME/.local/bin"

# add custom executables to PATH: ~/.config/bash/scripts/bin/
set SCIRPT_BINS "$BASH_SCRIPTS/bin"
prepend_path $SCIRPT_BINS || echo "warning: $SCIRPT_BINS not exists!"

# add custom rust-related commands
set RUST_SCRIPTS_BIN "$HOME/.config/rust/scripts/bin"
prepend_path "$RUST_SCRIPTS_BIN" || echo "warning: $RUST_SCRIPTS_BIN not exists!"

#
# OS specific
#---------------------------------

# archlinux specific
set ARCHBINS "$BASH_SCRIPTS/archbin"
$ARCHBINS/is_archlinux && prepend_path $ARCHBINS

