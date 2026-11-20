# env.fish -- environment variables

#======================================
# apps
#======================================

# manpage using $EDITOR, when it is a vim-like editor
if set -q EDITOR[1]; and string match -rq -- 'vim|nv' $EDITOR
    set -x MANPAGER "sh -c '$EDITOR +Man!'"
end

#======================================
# mirrors
#======================================

# one file for both shells, so the lists cannot drift
load_dotenv --shell fish (path resolve (status dirname)/..)/mirrors.env | source

#======================================
# .env
#======================================

# load ~/.env, silently when there is none
if test -f ~/.env
    load_dotenv --shell fish | source
end
