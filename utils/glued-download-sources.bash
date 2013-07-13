#! /bin/bash
#############################################################################
# Copyright (C) 2007-2013 Laboratório de Sistemas e Tecnologia Subaquática  #
# Departamento de Engenharia Electrotécnica e de Computadores               #
# Rua Dr. Roberto Frias, 4200-465 Porto, Portugal                           #
#############################################################################
# Author: Ricardo Martins                                                   #
#############################################################################
# $Id:: glued-download-sources.bash 1622 2013-06-25 08:31:22Z rasm        $:#
#############################################################################

if [ -f 'functions.bash' ]; then
    DST='downloads'
    PKGS='packages'
    source 'functions.bash'
elif [ -f '../functions.bash' ]; then
    DST='../downloads'
    PKGS='../packages'
    source '../functions.bash'
else
    echo "ERROR: unable to find functions.bash."
    exit 1
fi

mkdir -p "$DST"

find "$PKGS" -name '*.bash' | while read file; do
    url=()
    PKG_COMMON="$(dirname "$file")/common.bash"
    source "$file" 2> /dev/null
    n=0; while [ -n "${url[$n]}" ]; do
        m="${md5[$n]}"
        u="${url[$n]}"
        f="$DST/$(basename $u)"
        nfo1 "Verifying checksum of $f"
        fh="$(md5sum "$f" 2> /dev/null | cut -f1 -d' ')"
        if [ "$fh" != "$m" ]; then
            nfo1 "Downloading $f"
            echo ""
            wget -P "$DST" -4 -c "$u"
        fi
        let n++
        echo ""
    done
done
