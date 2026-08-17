# ~/.config/fish/conf.d/env.fish
#
# Setting environment variables for fish
#

#
#-- mirrors
#
# homebrew
set -x HOMEBREW_BREW_GIT_REMOTE "https://mirrors.ustc.edu.cn/brew.git"
set -x HOMEBREW_API_DOMAIN "https://mirrors.ustc.edu.cn/homebrew-bottles/api"
set -x HOMEBREW_BOTTLE_DOMAIN "https://mirrors.ustc.edu.cn/homebrew-bottles"
set -x HOMEBREW_ARTIFACT_DOMAIN "https://mirrors.ustc.edu.cn/homebrew-bottles"

# rust
set -x RUSTUP_DIST_SERVER "https://rsproxy.cn"
set -x RUSTUP_UPDATE_ROOT "https://rsproxy.cn/rustup"

# go
set -x GOPROXY "https://mirrors.tencent.com/go/"
