# ~/.config/fish/conf.d/env.fish
#
# Setting environment variables for fish
#

set -q __CONFIG_DIR; or set -g __CONFIG_DIR "$HOME/.config/bash"

#======================================
# apps
#======================================

# manpage using $EDITOR
if set -q EDITOR[1]; and string match -rq -- 'vim|nv' $EDITOR
    set -x MANPAGER "sh -c '$EDITOR +Man!'"
else
    set -e MANPAGER
end


#======================================
# mirrors
#======================================

# homebrew
set -x HOMEBREW_BREW_GIT_REMOTE "https://mirrors.ustc.edu.cn/brew.git"
set -x HOMEBREW_API_DOMAIN "https://mirrors.ustc.edu.cn/homebrew-bottles/api"
# set -x HOMEBREW_BOTTLE_DOMAIN "https://mirrors.ustc.edu.cn/homebrew-bottles"
set -x HOMEBREW_ARTIFACT_DOMAIN "https://mirrors.ustc.edu.cn/homebrew-bottles"

# huggingface
set -x HF_ENDPOINT "https://hf-mirror.com"

# rust
set -x RUSTUP_DIST_SERVER "https://rsproxy.cn"
set -x RUSTUP_UPDATE_ROOT "https://rsproxy.cn/rustup"

# go
set -x GOPROXY "https://mirrors.tencent.com/go/"


#======================================
# .env
#======================================

# load ~/.env
if test -f ~/.env
    load_dotenv --shell fish | source
end


#======================================
# os-specific
#======================================

if test "$__IS_ARCH" = true; and test -d /opt/libtorch # set in paths.fish
    set -gx LIBTORCH "/opt/libtorch"
    # LD_LIBRARY_PATH ends in PATH, so fish treats it as a list
    set -gx LD_LIBRARY_PATH "$LIBTORCH/lib" $LD_LIBRARY_PATH
    set -gx LIBTORCH_BYPASS_VERSION_CHECK "1"
end

