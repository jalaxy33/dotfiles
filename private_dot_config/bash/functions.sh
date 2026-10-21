#!/usr/bin/env bash
#
# functions.sh -- useful functions
#

# skip if loaded
[[ -n ${__FUNCTIONS_SH_LOADED:-} ]] && return 0
readonly __FUNCTIONS_SH_LOADED=1

# ==========================================
# Helper Functions
# ==========================================

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


# Source FILE(s) if they exist and are readable.
# Usage: try_source FILE [FILE...]
# Example: try_source "$HOME/.bashrc.local"
try_source() {
  local file
  for file in "$@"; do
    [[ -f $file && -r $file ]] || continue
    source "$file"
  done
  return 0
}

# load .env file
# usage:
#   load_dotenv                # loads ~/.env
#   load_dotenv /path/to/.env  # loads custom file
#   load_dotenv /path/to/.env --no-override  # do not override existing env vars
load_dotenv() {
  local file="${1:-$HOME/.env}"
  local no_override=false
  local has_error=0

  if [[ $2 == "--no-override" ]]; then
    no_override=true
  fi

  if [[ ! -f $file ]]; then
    echo "load_dotenv: $file not found" >&2
    return 1
  fi

  # Flag to handle BOM on first line only
  local bom_handled=0

  while IFS= read -r line || [[ -n $line ]]; do
    # ---------- 1. Handle UTF-8 BOM on first line ----------
    if ((bom_handled == 0)); then
      bom_handled=1
      # Remove BOM if present (three bytes: \xEF\xBB\xBF)
      if [[ $line == $'\xEF\xBB\xBF'* ]]; then
        line="${line:3}"
      fi
    fi

    # ---------- 2. Trim leading/trailing whitespace (POSIX-friendly) ----------
    # Remove leading whitespace
    local leading="${line%%[![:space:]]*}"
    line="${line#$leading}"
    # Remove trailing whitespace
    local trailing="${line##*[![:space:]]}"
    line="${line%$trailing}"

    # ---------- 3. Skip empty lines and comments ----------
    if [[ -z $line ]] || [[ $line == "#"* ]]; then
      continue
    fi

    # # stop a running systemd service
    # #  usage: stop_service xxx.service
    # stop_service() {
    #   systemctl stop "$1" 2>/dev/null
    # }
    #
    # # reboot after stopping some services
    # #   usage: tidy_reboot
    # tidy_reboot() {
    #   sudo stop_service daed
    #   sudo systemctl reboot
    # }
    # ---------- 4. Handle optional 'export' prefix ----------
    if [[ $line =~ ^export[[:space:]]+(.*) ]]; then
      # Remove 'export' and any following spaces
      line="${line#export}"
      # Trim again (left whitespace)
      local exp_leading="${line%%[![:space:]]*}"
      line="${line#$exp_leading}"
    fi

    # ---------- 5. Skip lines without '=' ----------
    if [[ $line != *"="* ]]; then
      echo "load_dotenv: skipping invalid line (no '='): $line" >&2
      has_error=1
      continue
    fi

    # ---------- 6. Split into key and value ----------
    local key="${line%%=*}"
    local value="${line#*=}"

    # Trim key (again, after potential spaces around '=')
    local key_leading="${key%%[![:space:]]*}"
    key="${key#$key_leading}"
    local key_trailing="${key##*[![:space:]]}"
    key="${key%$key_trailing}"

    if [[ -z $key ]]; then
      echo "load_dotenv: skipping empty key in line: $line" >&2
      has_error=1
      continue
    fi

    # ---------- 7. Strip matching quotes from value ----------
    if [[ $value == \'*\' && ${#value} -ge 2 ]]; then
      # Single quotes
      value="${value:1:${#value}-2}"
    elif [[ $value == \"*\" && ${#value} -ge 2 ]]; then
      # Double quotes
      value="${value:1:${#value}-2}"
    fi

    # ---------- 8. Optionally skip if variable already exists ----------
    if [[ $no_override == true ]] && [[ -n ${!key} ]]; then
      continue
    fi

    # ---------- 9. Export the variable ----------
    export "$key"="$value"
  done <"$file"

  return $has_error
}
