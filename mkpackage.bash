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
# Author: Ricardo Martins                                                 #
###########################################################################

source "functions.bash"

download_tool()
{
    wget -c "$1" -O "$2"
    if [ $? -eq 0 ]; then
        return 0
    fi

    curl -f -C - "$1" -o "$2"
    if [ $? -eq 0 ]; then
        return 0
    fi

    rm -f "$2"
    return 1
}

md5sum_tool()
{
    sum="$(md5sum < "$cfg_dir_downloads/$file" 2> /dev/null | cut -f1 -d' ')"

    if [ -n "$sum" ]; then
        echo "$sum"
    fi

    sum="$(md5 < "$cfg_dir_downloads/$file" 2> /dev/null)"
    if [ -n "$sum" ]; then
        echo "$sum"
    fi
}

download()
{
    n=0; while [ -n "${url[$n]}" ]; do

        u="${url[$n]}"
        s="${md5[$n]}"
        file=$(basename "$u")

        if [ -f "$cfg_dir_downloads/$file" ]; then
            md5=$(md5sum_tool "$cfg_dir_downloads/$file")

            if [ "$s" = "$md5" ]; then
                let n++
                continue
            fi
        fi

	# First try LSTS mirror.
	lsts_url="http://lsts.pt/glued/$(basename $u)"
        download_tool "$lsts_url" "$cfg_dir_downloads/$file"
        if [ $? -ne 0 ]; then
	    # Then try OceanScan-MST mirror.
            omst_url="http://www.omst.pt/glued/$(basename $u)"
            download_tool "$omst_url" "$cfg_dir_downloads/$file"
            if [ $? -ne 0 ]; then
		# On failure try upstream URL.
		download_tool "$u" "$cfg_dir_downloads/$file"
		if [ $? -ne 0 ]; then
                    echo "ERROR: download failed"
                    exit 1
		fi
            fi
	fi

        md5="$(md5sum_tool "$cfg_dir_downloads/$file")"
        if [ "$s" != "$md5" ]; then
            echo "ERROR: MD5 checksum mismatch: $s vs $md5"
            return 1
        fi

        let n++
    done

    n=0; while [ -n "${svn[$n]}" ]; do
        u="$(echo ${svn[$n]} | cut -f1 -d'#')"
        r="$(echo ${svn[$n]} | cut -f2 -d'#')"
        dir=$(basename $u)

        svn export -r "$r" "$u" "$cfg_dir_downloads/$dir"
        let n++
    done

    n=0; while [ -n "${git[$n]}" ]; do
        u="$(echo ${git[$n]} | cut -f1 -d'#')"
        b="$(echo ${git[$n]} | cut -f2 -d'#')"
        dir=$(basename $u)
        des="${cfg_dir_builds}/$pkg/$dir-git"

        if [[ "$u" == git* ]]; then
            git clone --verbose --branch "$b" "$u" "$des"
        else
            git clone --verbose               "$u" "$des"
        fi

        let n++
    done

    return 0
}

post_unpack()
{
    echo "using dummy 'post_unpack' hook."
}

unpack()
{
    n=0; while [ -n "${url[$n]}" ]; do
        u="${url[$n]}"
        s="${md5[$n]}"
        file=$(basename "$u")

        case $file in
            *tar*|*tgz|*tbz*)
                tar -C "$cfg_dir_builds/$pkg" -x -f "$cfg_dir_downloads/$file" || exit 1
                ;;
            *zip)
                unzip "$cfg_dir_downloads/$file" -d "$cfg_dir_builds/$pkg" || exit 1
                ;;
            *)
                echo "File $file can't be handled."
                ;;
        esac
        let n++
    done

    dir_gnu_cfg="$cfg_dir_toolchain/share/gnu-config"
    if [ "$cfg_dir_cfg/config.sub" ]; then
        find "$cfg_dir_builds/$pkg" -name config.sub -exec install -v -m 0755 "$dir_gnu_cfg/config.sub" '{}' \;
    fi

    if [ "$cfg_dir_cfg/config.guess" ]; then
        find "$cfg_dir_builds/$pkg" -name config.guess -exec install -v -m 0755 "$dir_gnu_cfg/config.guess" '{}' \;
    fi

    return 0
}

refresh()
{
    echo "Using dummy 'refresh' rule."
}

configure()
{
    echo "Using dummy 'configure' rule."
}

build()
{
    echo "Using dummy 'build' rule."
}

host_install()
{
    echo "Using dummy 'host_install' rule."
}

target_install()
{
    echo "Using dummy 'target_install' rule."
}

postconfigure()
{
    echo "Using dummy 'postconfigure' rule."
}

perform_clean()
{
    rm -rf "$cfg_dir_builds/$pkg/$pkg_var"
}

perform_all()
{
    start="$(date +%s)"
    nfo1 "$pkg / $pkg_var"

    export pkg_build_dir="$cfg_dir_builds/$pkg/$pkg_var"

    for rule in download unpack post_unpack refresh configure build host_install target_install postconfigure; do
        case $rule in
            download | unpack | post_unpack)
                marker="$cfg_dir_builds/$pkg/.$rule"
                ;;
            *)
                marker="$cfg_dir_builds/$pkg/$pkg_var/.$rule"
                ;;
        esac

        mkdir -p "$cfg_dir_builds/$pkg/$pkg_var" && cd "$cfg_dir_builds/$pkg/$pkg_var"

        if [ -z "$build_dir" ]; then
            build_dir="$pkg-$version"
        fi

        if [ -n "$build_dir" ]; then
            mkdir -p "$cfg_dir_builds/$pkg/$build_dir" && cd "$cfg_dir_builds/$pkg/$build_dir"
        fi

        if [ -n "$build_always" ] || [ "$rule" = 'refresh' ]; then
            nfo2 "$rule"
            $rule > "$cfg_dir_builds/$pkg/$pkg_var/$rule.log" 2>&1
        else
            if ! [ -f "$marker" ]; then
                nfo2 "$rule"
                $rule > "$cfg_dir_builds/$pkg/$pkg_var/$rule.log" 2>&1
                if [ $? -eq 0 ]; then
                    touch "$marker"
                else
                    err "failed to execute rule $rule of $pkg / $pkg_var"
                    tail "$cfg_dir_builds/$pkg/$pkg_var/$rule.log"
                    exit 1
                fi
            fi
        fi
    done

    elapsed=$[ $(date +%s)-$start ]
    ok "completed in ${elapsed}s"
    touch "$cfg_dir_builds/$pkg/$pkg_var/.complete"
}

# Check shell.
if [ -z "$BASH_VERSION" ]; then
    echo "ERROR: you must use bash to run this script."
    exit 1
fi

# Check command line arguments.
if [ $# -lt 2 ]; then
    echo "Usage: $0 <config> <package> [all|clean|download|unpack|configure|build|install]"
    exit 1
fi

# Read system configuration file.
if ! [ -f "$1" ]; then
    echo "ERROR: invalid configuration file '$1'"
    exit 1
fi

# Read system configuration file.
source "$1"

# Unset variables that may be a problem to this script.
unset LD_LIBRARY_PATH
unset CFLAGS
unset LDFLAGS
unset CXXFLAGS
export PKG_CONFIG_PATH="$cfg_dir_toolchain_sysroot/usr/lib/pkgconfig"
export LD_LIBRARY_PATH="$cfg_dir_toolchain/lib"

# Sanitize PATH.
paths="$(echo $PATH | sed 's%/\{1,\}%/%g')"
clean_path=""
while [ -n "$paths" ]; do
    path=$(echo "$paths" | cut -f1 -d:)
    paths=$(echo "$paths" | cut -f2- -d:)

    if [ "$path" = "$paths" ]; then
        paths=""
    fi

    if [ "$path" = "" ] || [ "$path" = "." ] || [ "$path" = "./" ]; then
        continue
    fi

    if [ "$path" = "$cfg_dir_toolchain/$cfg_target_canonical/bin" ]; then
        continue
    fi

    if [ "$path" = "$cfg_sys_family/toolchain/$cfg_target_canonical/bin" ]; then
        continue
    fi

    clean_path="$clean_path:$path"
done

export PATH="$cfg_dir_toolchain/bin$clean_path"

pkg="$(echo $2 | cut -f1 -d'/')"
pkg_var="$(echo $2 | cut -f2 -d'/')"

if [ "$pkg_var" = "$pkg" ]; then
    pkg_var='default'
fi

export pkg
export pkg_var
export pkg_common="$cfg_dir_rules/$pkg/common.bash"

if ! [ -d "$cfg_dir_rules/$pkg" ]; then
    echo "ERROR: package '$pkg' does not exist."
    exit 1
fi

if ! [ -f "$cfg_dir_rules/$pkg/$pkg_var.bash" ]; then
    echo "ERROR: variant '$pkg_var' of package '$pkg' does not exist."
    exit 1
fi

if [ -z "$3" ]; then
    rule="all"
else
    rule="$3"
fi

mkdir -p "$cfg_dir_downloads" "$cfg_dir_rootfs" "$cfg_dir_toolchain" "$cfg_dir_builds/$pkg"

export pkg_dir="$cfg_dir_rules/$pkg"

. "$cfg_dir_rules/$pkg/$pkg_var.bash"

# Postconfiguration:
if [ -e "$cfg_dir_postconfiguration/$pkg/$cfg_sys_name.bash" ]; then
#    echo "ERROR: postconfiguration exists '$pkg'."
#    echo "$cfg_dir_postconfiguration/$pkg/$cfg_sys_name.bash"
#    exit 1
. "$cfg_dir_postconfiguration/$pkg/$cfg_sys_name.bash"
fi

# Handle dependencies.
n=0; while [ -n "${requires[$n]}" ]; do
    req="${requires[$n]}"
    let n++

    if [ -z "$req" ]; then
        break
    fi

    if [ -f "$cfg_dir_builds/$req/.complete" ]; then
        continue
    fi

    "$0" "$1" "$req"
    if [ $? -ne 0 ]; then
        err "failed to build dependency for package $pkg / $pkg_var"
        exit 1
    fi
done

perform_"$rule"
