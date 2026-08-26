# ~/.bash/bash_env.sh
#
# Setting environment variables for bash
#

#
#-- apps
#
# manpage using $EDITOR
if [ -n "$EDITOR" ] && [[ "$EDITOR" == *vim* || "$EDITOR" == *nv* ]] ; then
    export MANPAGER="sh -c '$EDITOR +Man!'"
else
    unset MANPAGER
fi


#
#-- mirrors
#
# homebrew
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"
# export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
export HOMEBREW_ARTIFACT_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"

# huggingface
export HF_ENDPOINT="https://hf-mirror.com"

# rust
export RUSTUP_DIST_SERVER="https://mirrors.cernet.edu.cn/rustup"
export RUSTUP_UPDATE_ROOT="https://mirrors.cernet.edu.cn/rustup/rustup"

# go
export GOPROXY="https://mirrors.tencent.com/go/"
