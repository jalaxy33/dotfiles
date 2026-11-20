#!/bin/sh
# Keep Zed's vim_mode/helix_mode off in the chezmoi source and in the target.
# Registered under [hooks.add.post] and [hooks.re-add.post] in chezmoi.toml;
# both events are separate, so both entries are needed.
# Hooks also run on --dry-run, so do nothing there.
case "$CHEZMOI_ARGS" in *--dry-run*) exit 0 ;; esac

# zed's settings.json is JSONC (comments, trailing commas): jq would drop the
# comments and fail on the trailing commas, so patch the single lines instead.
pattern='^[[:space:]]*"(vim_mode|helix_mode)"[[:space:]]*:[[:space:]]*true'

for f in "$CHEZMOI_SOURCE_DIR/private_dot_config/zed/private_settings.json" \
         "${CHEZMOI_DEST_DIR:-$HOME}/.config/zed/settings.json"; do
    [ -f "$f" ] || continue
    grep -qE "$pattern" "$f" || continue
    # sed -i keeps the file mode, which matters: 0600 is what makes chezmoi
    # name the source file private_settings.json.
    sed -i -E 's/^([[:space:]]*"(vim_mode|helix_mode)"[[:space:]]*:[[:space:]]*)true/\1false/' "$f"
    echo "zed: vim_mode/helix_mode set to false in $f"
done
