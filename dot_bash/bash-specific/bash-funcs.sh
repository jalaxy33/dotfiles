# bash-functions.sh  -- bash specific functions

BREW_PREFIX="/home/linuxbrew/.linuxbrew"

# Initialize bash-completion, preferring system-installed version.
activate_bash_completion() {
  # Only run in interactive shells and avoid reloading.
  [[ -z $PS1 || -n ${BASH_COMPLETION_VERSINFO:-} ]] && return

  # Candidate paths in priority order (system first).
  local paths=(
    "/usr/share/bash-completion/bash_completion"
    "$BREW_PREFIX/etc/profile.d/bash_completion.sh"
  )

  local path
  for path in "${paths[@]}"; do
    if [[ -f $path ]]; then
      source "$path"
      return $? # Return source's exit status.
    fi
  done
  # No completion script found; do nothing.
}

# fish-like interactive behavior
activate_flyline() {
  local paths=(
    "/usr/lib/bash/libflyline.so"
    "$BREW_PREFIX/lib/bash/flyline"
  )

  local path
  for path in "${paths[@]}"; do
    if [[ -f $path ]]; then
      enable -f $path flyline
      return $?
    fi
  done
}
