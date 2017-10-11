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

# Check shell type.
if [ -z "$BASH_VERSION" ]; then
    echo "ERROR: you must use bash to run this script."
    exit 1
fi

if [ $# -ne 1 ]; then
    echo "Usage: $0 <config>"
    exit 1
fi

if ! [ -f "$1" ]; then
    echo "ERROR: configuration file '$1' does not exist."
    exit 1
fi

source "$1"

fakeroot_state='/tmp/.glued-fakeroot'
fakeroot="$cfg_dir_toolchain/bin/fakeroot -s $fakeroot_state -i $fakeroot_state"

rm "$fakeroot_state" && touch "$fakeroot_state"

$fakeroot -- chown -vR root:root "$cfg_dir_rootfs"

for d in bin sbin lib usr/bin usr/sbin usr/lib; do
    $fakeroot -- chmod -vR 0755 "$cfg_dir_rootfs"/$d
    $fakeroot -- chmod -vR 0755 "$cfg_dir_rootfs"/$d/*
    $fakeroot -- chown -vR root:root "$cfg_dir_rootfs"/$d/*
done

for d in dev boot etc; do
    $fakeroot -- chmod -vR 0755 "$cfg_dir_rootfs"/$d
    $fakeroot -- chmod -vR 0644 "$cfg_dir_rootfs"/$d/*
done

# Copy DTB.
if [ -n "$cfg_target_linux_dtb" ]; then
    cp -v "$cfg_dir_rootfs/boot/$(basename $cfg_target_linux_dtb)" "$cfg_dir_rootfs/boot/board.dtb"
fi

# Write config vars.
set | sort | grep ^cfg_ | egrep -v '^cfg_dir|^cfg_target|^cfg_host_|^cfg_toolchain|^cfg_rootfs_tar|^cfg_partitions' > "$cfg_dir_rootfs/etc/config"

$fakeroot -- chmod -v 0700 "$cfg_dir_rootfs/root"
$fakeroot -- chmod -v 1777 "$cfg_dir_rootfs/tmp" "$cfg_dir_rootfs/var/tmp"

$fakeroot -- tar \
    -p \
    -j \
    -c \
    -v \
    -C "$cfg_dir_rootfs" \
    -f "$cfg_rootfs_tar" \
    .
