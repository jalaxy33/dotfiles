# Check if running on Arch Linux or an Arch-based distro
# (matches ID=arch, or any distro with "arch" in ID_LIKE).
# Returns 0 on match, 1 otherwise.
#
# Usage:
#   if is_archlinux
#       echo "on Arch"
#   end
#
#   is_archlinux; and pacman -Syu

function is_archlinux
    test -r /etc/os-release; or return 1
    set -l id   (string match -rg '^ID="?([^"]*)"?$'      < /etc/os-release)
    set -l like (string match -rg '^ID_LIKE="?([^"]*)"?$' < /etc/os-release)
    test "$id" = arch; or string match -q '*arch*' -- "$like"
end
