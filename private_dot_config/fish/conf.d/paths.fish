# paths.fish -- Add paths to $env:PATH

# Add `~/.bash/bin/` to PATH, which contains custom commands
set SCIRPTS_DIR "$HOME/.bash/bin/"
test -d $SCIRPTS_DIR && prepend_path "$SCIRPTS_DIR" || echo "Warning: $SCIRPTS_DIR not exists!"

# add `~/.local/bin` to PATH
set LOCAL_BIN_DIR "$HOME/.local/bin"
test -d $LOCAL_BIN_DIR && prepend_path $LOCAL_BIN_DIR

# archlinux specific
set ARCH_BIN_DIR "$HOME/.local/bin/archbin"
test -d $ARCH_BIN_DIR && is_archlinux && prepend_path $ARCH_BIN_DIR

