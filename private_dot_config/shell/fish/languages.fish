# languages.fish -- languages related settings

# rustup's own file: puts ~/.cargo/bin in PATH
test -f "$HOME/.cargo/env.fish"; and source "$HOME/.cargo/env.fish"

# pnpm and bun
if test -d "$HOME/.local/share/pnpm"
    set -gx PNPM_HOME "$HOME/.local/share/pnpm"
end

if test -d "$HOME/.bun/bin"
    set -gx BUN_BIN_DIR "$HOME/.bun/bin"
end

# add PATHS for tools
set -l __paths \
    # cabal first: ghcup may ship its own copy
    $HOME/.cabal/bin \
    # ghcup
    $HOME/.ghcup/bin \
    # bun
    $BUN_BIN_DIR \
    # pnpm
    $PNPM_HOME \
    # npm
    $HOME/.npm-global/bin

prepend_path --shell fish $__paths | source
