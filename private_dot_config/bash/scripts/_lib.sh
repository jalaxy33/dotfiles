#!/bin/sh
#
# _lib.sh -- quoting helpers shared by the commands in bin/.
# Sourced, never executed.
#
# Usage:
#   case $0 in */*) __dir=${0%/*} ;; *) __dir=. ;; esac
#   . "$__dir/../_lib.sh"
#
#   shell_target=posix          # or fish, see set_shell_target
#   emit_set KEY VALUE
#   emit_prepend VAR DIR...
#
# The quoting helpers leave the escaped text in $_q, without the quotes.

# set_shell_target VALUE - normalize a --shell value, or exit 2
# Uses $PROG for the error message.
set_shell_target() {
  case ${1:-posix} in
    posix | sh | bash | zsh) shell_target=posix ;;
    fish) shell_target=fish ;;
    *)
      echo "${PROG:-emitter}: unknown --shell: $1 (use posix or fish)" >&2
      exit 2
      ;;
  esac
}

# sh_quote VALUE - escape for a single-quoted word; result in $_q
sh_quote() {
  _rest=$1
  _q=
  while :; do
    case $_rest in
      *"'"*)
        _q=$_q${_rest%%"'"*}"'\\''"
        _rest=${_rest#*"'"}
        ;;
      *)
        _q=$_q$_rest
        break
        ;;
    esac
  done
}

# fish_quote VALUE - escape for a single-quoted fish word; result in $_q
# Inside fish single quotes only \ and ' are special.
fish_quote() {
  _rest=$1
  _q=
  # backslashes first, so the quotes pass below cannot touch them
  while :; do
    case $_rest in
      *"\\"*)
        _q=$_q${_rest%%"\\"*}'\\'
        _rest=${_rest#*"\\"}
        ;;
      *)
        _q=$_q$_rest
        break
        ;;
    esac
  done
  _rest=$_q
  _q=
  while :; do
    case $_rest in
      *"'"*)
        _q=$_q${_rest%%"'"*}"\\'"
        _rest=${_rest#*"'"}
        ;;
      *)
        _q=$_q$_rest
        break
        ;;
    esac
  done
}

# emit_set KEY VALUE - export KEY='VALUE' / set -gx KEY 'VALUE'
emit_set() {
  case $shell_target in
    posix) sh_quote "$2"; printf "export %s='%s'\n" "$1" "$_q" ;;
    fish) fish_quote "$2"; printf "set -gx %s '%s'\n" "$1" "$_q" ;;
  esac
}

# emit_prepend VAR DIR... - put DIRs in front of VAR, keeping their order
# The old value is expanded at eval time, so a long PATH is never re-quoted
# here; ${VAR:+...} keeps a trailing empty element out when VAR is unset.
emit_prepend() {
  _var=$1
  shift
  case $shell_target in
    posix)
      _prefix=
      for _dir in "$@"; do
        sh_quote "$_dir"
        _prefix=$_prefix${_prefix:+:}"'$_q'"
      done
      printf 'export %s=%s${%s:+:$%s}\n' "$_var" "$_prefix" "$_var" "$_var"
      ;;
    fish)
      printf 'set -gx %s' "$_var"
      for _dir in "$@"; do
        fish_quote "$_dir"
        printf " '%s'" "$_q"
      done
      printf ' $%s\n' "$_var"
      ;;
  esac
}
