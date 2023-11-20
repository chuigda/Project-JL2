#!/usr/bin/env bash

JULIA_PATH="$(dirname $(which julia))/.."
JULIA_LIB_PATH="$(realpath $JULIA_PATH/lib)"

MSCM_PATH="$(dirname $(which mscm))/.."
MSCM_LIB_PATH="$(realpath $MSCM_PATH/lib)"
MSCM_LIB_EXT_PATH="$MSCM_LIB_PATH/ext"
MSCM_SHARE_PATH="$(realpath $MSCM_PATH/share)"
MSCM_SHARE_SCM_PATH="$MSCM_SHARE_PATH/scm"

LD_LIBRARY_PATH="$JULIA_LIB_PATH:$MSCM_LIB_PATH:$LD_LIBRARY_PATH" mscm \
    $MSCM_LIB_EXT_PATH/libcore.so \
    $MSCM_LIB_EXT_PATH/libstruct.so \
    $MSCM_LIB_EXT_PATH/libvec.so \
    $(realpath ./jlparse/libjlparse.so) \
    $MSCM_SHARE_SCM_PATH/std.scm \
    util.scm \
    ast.scm \
    astconv.scm \
    jlcc.scm \
    drill.scm \
    $@
