#! /bin/bash
###########################################################################
# GLUED: GNU/Linux Uniform Environment Distribution                       #
# Copyright (C) 2007-2017 Universidade do Porto - Faculdade de Engenharia #
# Laboratório de Sistemas e Tecnologia Subaquática (LSTS)                 #
###########################################################################
# This program is free software; you can redistribute it and/or modify    #
# it under the terms of the GNU General Public License as published by    #
# the Free Software Foundation; either version 2 of the License, or (at   #
# your option) any later version.                                         #
#                                                                         #
# This program is distributed in the hope that it will be useful, but     #
# WITHOUT ANY WARRANTY; without even the implied warranty of              #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU       #
# General Public License for more details.                                #
#                                                                         #
# You should have received a copy of the GNU General Public License       #
# along with this program; if not, write to the Free Software             #
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA           #
# 02110-1301 USA.                                                         #
###########################################################################

if [ -f 'functions.bash' ]; then
    PKGS='rules'
    source 'functions.bash'
elif [ -f '../functions.bash' ]; then
    PKGS='../rules'
    source '../functions.bash'
else
    echo "ERROR: unable to find functions.bash."
    exit 1
fi

list=()

while read file; do
    url=()
    PKG_COMMON="$(dirname "$file")/common.bash"
    source "$file" 2> /dev/null
    n=0;
    while [ -n "${url[$n]}" ]; do
        u="${url[$n]}"
        f="$(basename $u)"
        nfo1 "Checking $f"
	if [[ `echo $u | grep -i 'ftp://'` ]]; then
	    # FTP
	    echo "ftp - $u"
	    if ! [[ `wget -S --spider $u 2>&1 | grep "File.*$f.*exists"` ]]; then
		list+=("$f")
		err "Not available"
	    fi
	else
	    # HTTP
	    if ! [[ `wget -S --spider $u 2>&1 | grep 'HTTP/1.1 200 OK'` ]]; then
		echo $u
		list+=("$f")
		err "Not available"
	    fi
	fi
        let n++
    done
done < <(find "$PKGS" -name '*.bash' )

if [ ${#list[@]} -eq 0 ]; then
    ok "All sources are available"
else
    err "Missing sources (${#list[@]}):"
    for item in ${list[*]};
    do
	nfo2 $item
    done
fi
