# helper bash functions

# skip if loaded
if [[ -n ${__RUST_HELPERS_LOADED:-} ]]; then
  return 0
fi
readonly __RUST_HELPERS_LOADED=1

#======================================
# Bash env
#======================================

# prepend_path - Prepend dirs to PATH if exist and missing;
#  usage: prepend_path dir1 [dir2...]
prepend_path() {
  local dir
  for dir in "$@"; do
    # skip if not exists
    [[ -n $dir && -d $dir ]] || continue
    # skip if already in $PATH
    [[ ":$PATH:" == *":$dir:"* ]] || PATH="$dir:$PATH"
  done
  export PATH
  return 0
}

#======================================
# Checker
#======================================

# is_blank "value": true when empty or only whitespace.
# e.g. is_blank "$s" && echo "blank"
is_blank() {
  [[ ${1-} =~ ^[[:space:]]*$ ]]
}

# is_true "value": true for 1 true t yes y on (any case, blanks trimmed).
# e.g. is_true "$FLAG" && echo "on"
is_true() {
  local v="${1-}"

  # trim
  v="${v#"${v%%[![:space:]]*}"}"
  v="${v%"${v##*[![:space:]]}"}"

  case "${v,,}" in
    1 | true | t | yes | y | on) return 0 ;;
    *) return 1 ;;
  esac
}

# command_exist "cmd":  true when the command is on PATH.
# e.g. command_exist ls && echo "exist"
command_exist() {
  command -v "${1-}" >/dev/null 2>&1
}

# check if given value in list
#
# Usage:
# $ isin "$val" "${list[@]}"
#
# e.g. isin apple apple banana orange
isin() {
  local value="$1"
  shift
  local item
  for item in "$@"; do
    [[ $item == "$value" ]] && return 0
  done
  return 1
}

#======================================
# CLI
#======================================

# cli_base_args <prog> <version> <usage-func> [args...]: help/version -> print, exit 0.
# Other args are left to the caller.
# e.g. cli_base_args "$PROG" "$VERSION" usage "$@"
cli_base_args() {
  local prog="$1" version="$2" usage_fn="$3"
  shift 3

  local opt
  for opt in "$@"; do
    case "$opt" in
      --) break ;;
      -h | --help)
        "$usage_fn"
        exit 0
        ;;
      -v | --version)
        printf '%s %s\n' "$prog" "$version"
        exit 0
        ;;
    esac
  done
}

# Check if the provided command-line argument valid.
# Return 0 when valid, otherwise 1.
#
# Usage:
# $ is_valid_cli_arg "$arg" opt1 opt2 ... || echo "invalid"
is_valid_cli_arg() {
  local value="$1" opt
  shift
  for opt in "$@"; do
    [[ $opt == "$value" ]] && return 0
  done
  return 1
}

# Make sure given command-line argument is valid. Otherwise exit
#
# Usage:
# $ require_valid_cli_arg "info" "$arg" opt1 opt2...
#
# "info" should be something like "-h, --help"
require_valid_cli_arg() {
  local info="$1"
  local value="$2"
  shift 2
  if ! is_valid_cli_arg "$value" "$@"; then
    echo "[Error] Invalid argument for '$info', received '$value' (options: $@)" >&2
    exit 1
  fi
}

# Make sure given command-line argument is valid.
# Pass when it is valid or empty, otherwise exit
#
# Usage:
# $ require_valid_cli_arg "info" "$arg" opt1 opt2...
#
# "info" should be something like "-h, --help"
require_valid_optional_cli_arg() {
  local info="$1"
  local value="$2"
  shift 2
  # skip checking if it is empty
  is_blank $value && return 0 || require_valid_cli_arg "$info" "$value" "$@"
}

#======================================
# File & Path
#======================================

# Make sure all given paths exist. Otherwise exit.
require_paths() {
  local p
  for p in "$@"; do
    [[ -e $p ]] || {
      printf 'error: missing: %s\n' "$p" >&2
      exit 1
    }
  done
}

# read_trimmed <file>: print <file> without leading/trailing blank lines.
# Whitespace-only lines count as blank. Output ends with a newline.
# Returns 1 if <file> is not a regular file.
read_trimmed() {
  local file="${1-}"
  if [[ ! -f $file ]]; then
    printf 'read_trimmed: not a regular file: %s\n' "${file:-<empty>}" >&2
    return 1
  fi
  awk '
        { sub(/\r$/, "") }
        /^[[:space:]]*$/ { if (started) blank++; next }
        { while (blank > 0) { print ""; blank-- } started = 1; print }
    ' "$file"
}

#======================================
# Interactive Choosing
#======================================

# confirm "prompt" [default y|n]: 0 for yes, 1 for no.
# e.g. confirm "Continue?" && echo "yes"
confirm() {
  local prompt="${1:-Are you sure?}"
  local default="${2:-y}"
  local hint="[Y/n]"
  local answer

  # Hint matches the default.
  if [[ $default == "n" ]]; then
    hint="[y/N]"
  fi

  while true; do
    # -r keeps backslashes; -p writes the prompt to stderr (tty only).
    if ! read -r -p "$prompt $hint " answer; then
      # EOF or unreadable stdin: use the default.
      answer="$default"
      printf '\n' >&2
    fi
    # Empty line means default.
    answer="${answer:-$default}"

    case "$answer" in
      [Yy] | [Yy][Ee][Ss]) return 0 ;; # y / yes, any case
      [Nn] | [Nn][Oo]) return 1 ;;     # n / no, any case
      *) printf 'Please answer yes or no.\n' >&2 ;;
    esac
  done
}

# choose_from "prompt" "default-or-empty" <option>...
# Print the pick on stdout. 0 on pick, 1 on abort, 2 on misuse.
# Pass "" as the second argument to omit the default.
# e.g. pick=$(choose_from "Pick one" b a b c) && echo "$pick"
choose_from() {
  local prompt="${1:-Choose one}"
  local default="${2-}"
  local -a opts=("${@:3}")
  local answer o ok i list hint

  if ((${#opts[@]} == 0)); then
    printf 'error: choose_from needs at least one option\n' >&2
    return 2
  fi

  # Drop a default that is not among the options.
  if [[ -n $default ]]; then
    ok=""
    for o in "${opts[@]}"; do
      [[ $o == "$default" ]] && ok=1
    done
    if [[ -z $ok ]]; then
      printf 'warning: default %q is not an option, ignoring it\n' "$default" >&2
      default=""
    fi
  fi

  # Hint looks like [a/b/c] (default: b).
  list="$(
    IFS=/
    printf '%s' "${opts[*]}"
  )"
  hint="[$list]"
  if [[ -n $default ]]; then
    hint="$hint (default: $default)"
  fi

  while true; do
    # -r keeps backslashes; -p writes the prompt to stderr (tty only).
    if ! read -r -p "$prompt $hint " answer; then
      # EOF or unreadable stdin: use the default, else abort.
      printf '\n' >&2
      if [[ -n $default ]]; then
        printf '%s\n' "$default"
        return 0
      fi
      return 1
    fi

    # Empty line means the default.
    if [[ -z $answer ]]; then
      if [[ -n $default ]]; then
        printf '%s\n' "$default"
        return 0
      fi
      printf 'Please choose one of: %s\n' "$list" >&2
      continue
    fi

    # Accept a 1-based index as well.
    if [[ $answer =~ ^[0-9]+$ ]]; then
      i=$((answer - 1))
      if ((i >= 0 && i < ${#opts[@]})); then
        printf '%s\n' "${opts[i]}"
        return 0
      fi
    fi

    # Case-insensitive match, same as confirm.
    for o in "${opts[@]}"; do
      if [[ ${o,,} == "${answer,,}" ]]; then
        printf '%s\n' "$o"
        return 0
      fi
    done

    printf 'Please choose one of: %s\n' "$list" >&2
  done
}

# collect_answer "prompt" [default]
# Print the user's input on stdout. Return 0 on input, 1 on EOF.
# e.g. ans=$(collect_answer "Name?") && echo "$ans" || echo "failed" >&2
collect_answer() {
  local prompt="${1:-}"
  local default="${2-}"
  local hint="" answer

  [[ -n $default ]] && hint=" (default: $default)"

  if ! read -r -p "$prompt$hint " answer; then
    printf '\n' >&2
    return 1
  fi

  printf '%s\n' "${answer:-$default}"
}
