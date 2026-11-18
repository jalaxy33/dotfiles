#!/usr/bin/env bash
#
# env.sh -- environment variables
#

[[ -n ${__ENV_SH_LOADED:-} ]] && return 0
readonly __ENV_SH_LOADED=1

# directory of this file
[[ -n ${__CONFIG_DIR:-} ]] ||
  __CONFIG_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}")" && pwd -P)

source "$__CONFIG_DIR/paths.sh"

#======================================
# apps
#======================================

# manpage using $EDITOR
if [[ -n $EDITOR && ($EDITOR == *vim* || $EDITOR == *nv*) ]]; then
  export MANPAGER="sh -c '$EDITOR +Man!'"
else
  unset MANPAGER
fi

#======================================
# mirrors
#======================================

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

#======================================
# .env
#======================================

# load ~/.env
if [[ -f ~/.env ]]; then
  eval "$(load_dotenv)"
fi

#======================================
# os-specific
#======================================

if [[ $__IS_ARCH == true && -d /opt/libtorch ]]; then
  export LIBTORCH="/opt/libtorch"
  export LD_LIBRARY_PATH="$LIBTORCH/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
  export LIBTORCH_BYPASS_VERSION_CHECK="1"
fi
