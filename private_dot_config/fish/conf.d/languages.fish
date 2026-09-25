# ~/.config/fish/conf.d/languages.fish
#
# languages related settings
#


# rust
test -f "$HOME/.cargo/env.fish" && source "$HOME/.cargo/env.fish"

# npm
if test -d "$HOME/.npm-global/bin"
  prepend_path "$HOME/.npm-global/bin"
end

# pnpm
if test -d "$HOME/.local/share/pnpm"
    set -gx PNPM_HOME "$HOME/.local/share/pnpm"
    prepend_path $PNPM_HOME
end

# bun
if test -d "$HOME/.bun/bin"
    set -gx BUN_BIN_DIR "$HOME/.bun/bin"
    prepend_path $BUN_BIN_DIR
end

# haskell
test -d "$HOME/.ghcup/bin" && prepend_path "$HOME/.ghcup/bin" 
test -d "$HOME/.cabal/bin" && prepend_path "$HOME/.cabal/bin"

