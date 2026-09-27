# Source FILE(s) if they exist and are readable.
# Usage: try_source FILE [FILE...]
# Example: try_source "$HOME/.config/fish/local.fish"
function try_source
    for file in $argv
        test -f "$file"; and test -r "$file"; or continue
        source "$file"
    end
    return 0
end
