# ~/.config/fish/conf.d/languages.fish
#
# languages related settings
#


# rust
try_source "$HOME/.cargo/env.fish"

# npm
prepend_path "$HOME/.npm-global/bin"

# pnpm
set PNPM_HOME "$HOME/.local/share/pnpm"
if test -d "$PNPM_HOME"
    set -gx PNPM_HOME $PNPM_HOME
    prepend_path $PNPM_HOME
end

# bun
set BUN_BIN_DIR "$HOME/.bun/bin"
if test -d "$BUN_BIN_DIR"
    set -gx BUN_BIN_DIR $BUN_BIN_DIR
    prepend_path $BUN_BIN_DIR
end

# haskell
prepend_path "$HOME/.ghcup/bin" 
prepend_path "$HOME/.cabal/bin"

