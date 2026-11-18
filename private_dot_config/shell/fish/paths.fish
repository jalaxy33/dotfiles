# paths.fish -- add directories to PATH

# root of the shell configs
set -l __SHELL_DIR (path resolve (status dirname)/..)

# ==========================================
# OS Probe
# ==========================================

set -l __IS_ARCH false
$__SHELL_DIR/scripts/archbin/is_archlinux; and set -l __IS_ARCH true

# ==========================================
# Set Paths
# ==========================================

set -l __paths \
    # custom rust-related commands
    $HOME/.config/rust/scripts/bin \
    # our own commands: clear_pi, rm_except, ...
    $__SHELL_DIR/scripts/bin \
    # user-installed commands
    $HOME/.local/bin \
    # homebrew
    /home/linuxbrew/.linuxbrew/bin

# archlinux only: is_archlinux, ensure-*
test "$__IS_ARCH" = true; and set -a __paths $__SHELL_DIR/scripts/archbin

# scripts/bin is not on PATH yet, so use the full path here
$__SHELL_DIR/scripts/bin/prepend_path --shell fish $__paths | source

# ==========================================
# Libraries
# ==========================================

# libtorch, archlinux only
if test "$__IS_ARCH" = true; and test -d /opt/libtorch
    set -gx LIBTORCH "/opt/libtorch"
    # LD_LIBRARY_PATH ends in PATH, so fish treats it as a list
    set -gx LD_LIBRARY_PATH "$LIBTORCH/lib" $LD_LIBRARY_PATH
    set -gx LIBTORCH_BYPASS_VERSION_CHECK "1"
end
