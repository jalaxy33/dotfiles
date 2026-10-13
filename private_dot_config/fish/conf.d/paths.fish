# paths.fish -- Add paths to $env:PATH


# add `~/.local/bin` to PATH
prepend_path "$HOME/.local/bin"


# Add custom executable scripts to PATH: `~/.local/bin/scripts/`
set SCIRPTS_DIR "$HOME/.local/bin/scripts"
test -d "$SCIRPTS_DIR" && prepend_path "$SCIRPTS_DIR" || echo "Warning: $SCIRPTS_DIR not exists!"

# Add custom rust-related commands
set RUST_SCRIPTS_BIN "$HOME/.config/rust/scripts/bin"
test -d "$RUST_SCRIPTS_BIN" && prepend_path "$RUST_SCRIPTS_BIN" || echo "Warning: $RUST_SCRIPTS_BIN not exists!"

# archlinux specific
set ARCH_BIN_DIR "$HOME/.local/bin/archbin"
is_archlinux && prepend_path $ARCH_BIN_DIR

