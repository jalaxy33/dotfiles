# device specific settings

# libtorch
set -x LIBTORCH /opt/libtorch
[ -d $LIBTORCH ] && set -x LD_LIBRARY_PATH "$LIBTORCH/lib":$LD_LIBRARY_PATH
set -x LIBTORCH_BYPASS_VERSION_CHECK 1
