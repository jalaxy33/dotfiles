# paths.fish -- Add paths to $env:PATH

set BASH_SCRIPTS "$HOME/.config/bash/scripts"

# ==========================================
# Set Paths
# ==========================================

# add `~/.local/bin/` to PATH
set LOCAL_BINS "$HOME/.local/bin"
test -d $LOCAL_BINS && prepend_path "$LOCAL_BINS"

# add custom executables to PATH: ~/.config/bash/scripts/bin/
set SCIRPT_BINS "$BASH_SCRIPTS/bin"
test -d $SCIRPT_BINS && prepend_path $SCIRPT_BINS || echo "warning: $SCIRPT_BINS not exists!"

# add custom rust-related commands
set RUST_SCRIPTS_BIN "$HOME/.config/rust/scripts/bin"
test -d "$RUST_SCRIPTS_BIN" && prepend_path "$RUST_SCRIPTS_BIN" || echo "warning: $RUST_SCRIPTS_BIN not exists!"

#
# OS specific
#---------------------------------

# archlinux specific
set ARCHBINS "$BASH_SCRIPTS/archbin"
$ARCHBINS/is_archlinux && prepend_path $ARCHBINS

