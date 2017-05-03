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

# Config: GLUED version.
cfg_glued_version='2016.05'
# Config: GLUED vendor.
cfg_glued_vendor='lsts'

# Check shell type.
if [ -z "$BASH_VERSION" ]; then
    echo "ERROR: you must use bash to run this script."
    exit 1
fi

# Validate command line parameters.
if [ $# -ne 1 ]; then
    echo "Usage: $0 <system>"
    exit 1
fi

# Check if user requested system list.
if [ "$1" = "list" ]; then
    for family in $(ls -1 systems | sort); do
        echo -e "\n  + Family $family"
        find "systems/$family" -name '*.cfg' | egrep -v "devlinks|linux-[0-9.]*.cfg" | while read s; do
            echo "    - $(basename "$s" .cfg)"
        done | sort
    done

    echo ""
    exit 1
fi

# Check number of CPU cores.
if [ -f /proc/cpuinfo ]; then
    cfg_host_cores="$(grep "processor[^:]:" /proc/cpuinfo | wc -l)"
fi

if [ -z "$cfg_host_cores" ]; then
    cfg_host_cores=1
fi

# Find system configuration files.
if [ -f "systems/"*"/$1.cfg" ]; then
    system_cfg="$(echo "systems/"*"/$1.cfg")"

    family_cfg="$(dirname $system_cfg)/config"
    if ! [ -f "$family_cfg" ]; then
        echo "ERROR: no base configuration available for system '$1'"
        exit 1
    fi
    family_dir="$(dirname $family_cfg)"
    family_name="$(basename $family_dir)"
    source "$family_cfg"

    if ! [ -f "$system_cfg" ]; then
        echo "ERROR: no configuration available for system '$1'"
        exit 1
    fi

    source "$system_cfg"

fi

# Read architecture configuration.
if ! [ -f "architectures/$cfg_architecture.cfg" ]; then
    echo "ERROR: configuration for '$1' architecture does not exist"
    exit 1
fi
source "architectures/$cfg_architecture.cfg"

# Create a MAC address based on the IP address if cfg_eth_ext_soft_mac
# is set.
if [ -n "$cfg_eth_ext_ip" ] && [ -n "$cfg_eth_ext_soft_mac" ]; then
    ips=(`echo $cfg_eth_ext_ip | sed -e 's/\./\n/g'`)
    for i in "${ips[@]}"
    do
        hip=("${hip[@]}" `printf '%x' $i`)
    done
    cfg_eth_ext_mac="80:c1:${hip[0]}:${hip[1]}:${hip[2]}:${hip[3]}"
fi

# Config: system name.
if [ -z $cfg_sys_name ]; then
  cfg_sys_name="$1"
fi
# Config: system family.
cfg_sys_family="$family_name"
# Config: GLUED source tree base path.
cfg_dir_base="$PWD"
# Config: system configuration folder.
cfg_dir_system="$cfg_dir_base/$family_dir"
# Config: package rules folder.
cfg_dir_rules="$cfg_dir_base/rules"
# Config: configuration rules folder.
cfg_dir_postconfiguration="$cfg_dir_base/postconfiguration"
# Config: package sources folder.
cfg_dir_downloads="$cfg_dir_base/downloads"
# Config: build folder.
cfg_dir_builds="$cfg_dir_base/$cfg_sys_family/builds"
# Config: toolchain destination folder.
cfg_dir_toolchain="$cfg_dir_base/$cfg_sys_family/toolchain"
# Config: root filesystem folder.
cfg_dir_rootfs="$cfg_dir_base/$cfg_sys_family/rootfs"
# Config: system root folder.
cfg_dir_toolchain_sysroot="$cfg_dir_toolchain/$cfg_target_canonical/sysroot"
# Target prefix:
cmd_target_prefix="$cfg_dir_toolchain/bin/$cfg_target_canonical-"
# Config: target C compiler executable.
cmd_target_cc="$cfg_dir_toolchain/bin/$cfg_target_canonical-gcc"
# Config: target C pre-processor executable.
cmd_target_cpp="$cfg_dir_toolchain/bin/$cfg_target_canonical-cpp"
# Config: target C++ compiler executable.
cmd_target_cxx="$cfg_dir_toolchain/bin/$cfg_target_canonical-g++"
# Config: target archiver executable.
cmd_target_ar="$cfg_dir_toolchain/bin/$cfg_target_canonical-ar"
# Config: target linker executable.
cmd_target_ld="$cfg_dir_toolchain/bin/$cfg_target_canonical-ld"
# Config: target strip executable.
cmd_target_strip="$cfg_dir_toolchain/bin/$cfg_target_canonical-strip"
# Config: target archive indexer executable.
cmd_target_ranlib="$cfg_dir_toolchain/bin/$cfg_target_canonical-ranlib"
# Config: host compiler executable.
cmd_host_cc="gcc"
# Command: strip command.
cmd_target_strip="$cmd_target_strip --strip-unneeded"
# Command: command to create folders.
cmd_mkdir="mkdir -pv"
# Command: copy data.
cmd_cp="cp -avr"
# Command: allow execution.
cmd_chmod755="chmod 755"
# Config: host canonical name.
cfg_host_canonical="$($cmd_host_cc -dumpmachine 2> /dev/null)"
# Command: make command with one process.
cmd_make_single="make -j1"
# Command: make command.
cmd_make="make -j$cfg_host_cores"
# Config: rootfs tar file.
if [ -z $cfg_rootfs_tar ]; then
    cfg_rootfs_tar="$cfg_dir_base/$cfg_sys_family/glued-$cfg_glued_version-$cfg_sys_name-rootfs.tar.bz2"
fi
# Config: toolchain tar file.
if [ -z $cfg_toolchain_tar ]; then
    cfg_toolchain_tar="$cfg_dir_base/$cfg_sys_family/glued-$cfg_glued_version-$cfg_sys_family-toolchain-$cfg_host_canonical-$cfg_target_canonical.tar.bz2"
fi

# Config: Git revision.
git_branch=$(echo $(git rev-parse --symbolic-full-name --abbrev-ref HEAD 2> /dev/null))
git_revision=$(echo $(git rev-parse --short HEAD 2> /dev/null))
git_status=$(echo $(git status -s 2> /dev/null))
if [ -z "$git_branch" ] || [ -z "$git_revision" ]; then
    cfg_glued_git_version='unknown'
else
    cfg_glued_git_version="$git_branch-$git_revision"
    if [ -n "$git_status" ]; then
        cfg_glued_git_version="$cfg_glued_git_version-dirty"
    fi
fi

if ! [ -d "$cfg_sys_family" ]; then
    mkdir -p "$cfg_sys_family"
fi &&

# Save configuration values to file.
set \
    | egrep '^cfg_|^cmd_' \
    | awk '{print "export " $0}' \
    > "$cfg_sys_family/$1.bash"

echo "Configuration file written to '$cfg_sys_family/$1.bash'"
