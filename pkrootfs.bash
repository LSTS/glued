#! /bin/bash
#############################################################################
# Copyright (C) 2007-2012 Laboratório de Sistemas e Tecnologia Subaquática  #
# Departamento de Engenharia Electrotécnica e de Computadores               #
# Rua Dr. Roberto Frias, 4200-465 Porto, Portugal                           #
#############################################################################
# Author: Ricardo Martins                                                   #
#############################################################################
# $Id::                                                                   $:#
#############################################################################

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
