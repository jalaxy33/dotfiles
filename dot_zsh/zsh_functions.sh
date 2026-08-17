# ~/.zsh/zsh_functions.sh

function get_zimfw() {
  # decide which zimfw to use: system-wise or homebrew
  # default: homebrew zimfw
  SYSTEM_ZIMFW_ZSH="/usr/share/zimfw/zimfw.zsh"
  BREW_ZIMFW_ZSH="/home/linuxbrew/.linuxbrew/opt/zimfw/share/zimfw.zsh"

  local ZIMFW_SCRIPT=""
  if [[ -f $BREW_ZIMFW_ZSH ]]; then
    ZIMFW_SCRIPT=$BREW_ZIMFW_ZSH
  elif [[ -f $SYSTEM_ZIMFW_ZSH ]]; then
    ZIMFW_SCRIPT=$SYSTEM_ZIMFW_ZSH
  fi

  echo $ZIMFW_SCRIPT
}

function activate_zimfw() {
  ZIMFW_SCRIPT=$(get_zimfw)

  # activate
  if [[ -f $ZIMFW_SCRIPT ]]; then
    [[ ! -f $HOME/.zimrc ]] && echo "Warning: $HOME/.zimrc not exist!"

    ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
    # Install missing modules and update ${ZIM_HOME}/init.zsh if missing or outdated.
    if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
      source $ZIMFW_SCRIPT init
    fi

    # Initialize modules.
    source ${ZIM_HOME}/init.zsh

    # Modules configuration
    ZSH_AUTOSUGGEST_MANUAL_REBIND=1
  fi
}
