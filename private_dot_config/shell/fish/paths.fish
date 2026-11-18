# paths.fish -- add directories to PATH

# ==========================================
# OS Probe
# ==========================================

set -g __IS_ARCH false
$__CONFIG_DIR/scripts/archbin/is_archlinux; and set -g __IS_ARCH true

# ==========================================
# Set Paths
# ==========================================

# First entry wins; missing directories are skipped.
set -g __paths \
    # custom rust-related commands
    $HOME/.config/rust/scripts/bin \
    # our own commands: clear_pi, rm_except, ...
    $__CONFIG_DIR/scripts/bin \
    # user-installed commands
    $HOME/.local/bin \
    # homebrew
    /home/linuxbrew/.linuxbrew/bin

# archlinux only: is_archlinux, ensure-*
test "$__IS_ARCH" = true; and set -a __paths $__CONFIG_DIR/scripts/archbin

# scripts/bin is not on PATH yet, so use the full path here
$__CONFIG_DIR/scripts/bin/prepend_path --shell fish $__paths | source
