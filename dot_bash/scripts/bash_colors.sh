#!/usr/bin/env bash
#
# bash_colors.sh -- comprehensive terminal colors and styles.
#
# Fast loading: indexed colors are generated with built-in printf,
# not by spawning tput hundreds of times.

# ---------------------------------------------------------------------------
# Capability detection
# ---------------------------------------------------------------------------
if [[ -z "${NO_COLOR:-}" ]] && [[ -t 1 ]] && command -v tput >/dev/null 2>&1; then
    COLOR_ENABLED=1
    _tput() { tput "$@" 2>/dev/null || true; }
    COLOR_COUNT=$(_tput colors)
else
    COLOR_ENABLED=0
    _tput() { :; }
    COLOR_COUNT=0
fi
COLOR_COUNT=${COLOR_COUNT:-0}
(( COLOR_COUNT > 256 )) && COLOR_COUNT=256

# ---------------------------------------------------------------------------
# Styles (few tput calls, keep for maximum compatibility)
# ---------------------------------------------------------------------------
RESET=$(_tput sgr0)
BOLD=$(_tput bold)
DIM=$(_tput dim)
ITALIC=$(_tput sitm)
UNDERLINE=$(_tput smul)
BLINK=$(_tput blink)
REVERSE=$(_tput rev)
HIDDEN=$(_tput invis)
STRIKETHROUGH=$(_tput smxx)
STANDOUT=$(_tput smso)

NO_ITALIC=$(_tput ritm)
NO_UNDERLINE=$(_tput rmul)
NO_REVERSE=$(_tput rmso)
NO_STRIKETHROUGH=$(_tput rmxx)
NO_STANDOUT=$(_tput rmso)

# ---------------------------------------------------------------------------
# Indexed colors: FG_0 .. FG_255, BG_0 .. BG_255
#
# ANSI mapping:
#   0-7     standard:    foreground 30-37, background 40-47
#   8-15    bright:      foreground 90-97, background 100-107
#   16-255  256-color:   foreground 38;5;N, background 48;5;N
# ---------------------------------------------------------------------------
for ((i = 0; i < 256; i++)); do
    if (( i < COLOR_COUNT )); then
        if (( i < 8 )); then
            printf -v "FG_$i" '\e[%dm' "$((30 + i))"
            printf -v "BG_$i" '\e[%dm' "$((40 + i))"
        elif (( i < 16 )); then
            printf -v "FG_$i" '\e[%dm' "$((90 + i - 8))"
            printf -v "BG_$i" '\e[%dm' "$((100 + i - 8))"
        else
            printf -v "FG_$i" '\e[38;5;%dm' "$i"
            printf -v "BG_$i" '\e[48;5;%dm' "$i"
        fi
    else
        printf -v "FG_$i" '%s' ''
        printf -v "BG_$i" '%s' ''
    fi
done

# ---------------------------------------------------------------------------
# Standard foreground aliases
# ---------------------------------------------------------------------------
BLACK=${FG_0:-}
RED=${FG_1:-}
GREEN=${FG_2:-}
YELLOW=${FG_3:-}
BLUE=${FG_4:-}
MAGENTA=${FG_5:-}
CYAN=${FG_6:-}
WHITE=${FG_7:-}

BRIGHT_BLACK=${FG_8:-}
BRIGHT_RED=${FG_9:-}
BRIGHT_GREEN=${FG_10:-}
BRIGHT_YELLOW=${FG_11:-}
BRIGHT_BLUE=${FG_12:-}
BRIGHT_MAGENTA=${FG_13:-}
BRIGHT_CYAN=${FG_14:-}
BRIGHT_WHITE=${FG_15:-}

# ---------------------------------------------------------------------------
# Standard background aliases
# ---------------------------------------------------------------------------
BG_BLACK=${BG_0:-}
BG_RED=${BG_1:-}
BG_GREEN=${BG_2:-}
BG_YELLOW=${BG_3:-}
BG_BLUE=${BG_4:-}
BG_MAGENTA=${BG_5:-}
BG_CYAN=${BG_6:-}
BG_WHITE=${BG_7:-}

BG_BRIGHT_BLACK=${BG_8:-}
BG_BRIGHT_RED=${BG_9:-}
BG_BRIGHT_GREEN=${BG_10:-}
BG_BRIGHT_YELLOW=${BG_11:-}
BG_BRIGHT_BLUE=${BG_12:-}
BG_BRIGHT_MAGENTA=${BG_13:-}
BG_BRIGHT_CYAN=${BG_14:-}
BG_BRIGHT_WHITE=${BG_15:-}

# ---------------------------------------------------------------------------
# Truecolor / 24-bit helpers
# ---------------------------------------------------------------------------
fg_rgb() {
    [[ "${COLOR_ENABLED:-0}" == 1 ]] || return 0
    printf '\033[38;2;%s;%s;%sm' "$1" "$2" "$3"
}

bg_rgb() {
    [[ "${COLOR_ENABLED:-0}" == 1 ]] || return 0
    printf '\033[48;2;%s;%s;%sm' "$1" "$2" "$3"
}

# ---------------------------------------------------------------------------
# Cleanup
# ---------------------------------------------------------------------------
unset i
unset -f _tput
