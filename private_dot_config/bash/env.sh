#!/usr/bin/env bash
#
# env.sh -- Setting environment variables for bash
#

CURRENT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)

source "$CURRENT_DIR/functions.sh"
source "$CURRENT_DIR/paths.sh"

# skip if loaded
if [[ -n ${__ENV_SH_LOADED:-} ]]; then
  return 0
fi
readonly __ENV_SH_LOADED=1

#======================================
# apps
#======================================

# manpage using $EDITOR
if [ -n "$EDITOR" ] && [[ $EDITOR == *vim* || $EDITOR == *nv* ]]; then
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
[[ -f ~/.env ]] && load_dotenv

#======================================
# os-specific
#======================================

# libtorch
if is_archlinux && [ -d /opt/libtorch ]; then
  export LIBTORCH="/opt/libtorch"
  export LD_LIBRARY_PATH="$LIBTORCH/lib":$LD_LIBRARY_PATH
  export LIBTORCH_BYPASS_VERSION_CHECK="1"
fi
