# prepend_path - Prepend dirs to PATH if they exist and are missing;
#  usage: prepend_path dir1 [dir2...]
function prepend_path
    for dir in $argv
        # skip if not exist
        test -n "$dir" -a -d "$dir"; or continue
        # skip if already in $PATH
        contains -- $dir $PATH; and continue
        set -p PATH $dir
    end
    return 0
end
