#! /bin/bash
###########################################################################
# GLUED: GNU/Linux Uniform Environment Distribution                       #
# Copyright (C) 2007-2014 Universidade do Porto - Faculdade de Engenharia #
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

cmd_parted()
{
    bdev="$1"; shift
    "$cmd_parted" "$bdev" -a cylinder -s -- $@
}

cmd_mount()
{
    fs="$1"
    bdev="$2"
    mkdir -p mount &&
    mount -t "$fs" "$bdev" mount
}

cmd_unmount()
{
    while [ 1 ]; do
        (umount mount && rmdir mount) > /dev/null 2>&1
        [ $? -eq 0 ] && break
        sleep 1
    done
}

die()
{
    umount -v mount > /dev/null 2>&1
    rmdir mount > /dev/null 2>&1
    [ -n "$dev_loop" ] && losetup -d "$dev_loop"
    exit 1
}

create_part_xboot()
{
    nfo1 "X-Boot partition ($part_label)"

    nfo2 "Creating partition"
    cmd_parted "$dev_loop" \
        mkpart primary fat32 "$part_start" "$part_end" \
        set "$part_nr" boot on \
        align-check minimal "$part_nr" \
        || die

    nfo2 "Creating filesystem"
    $cmd_mkdosfs -n "$part_label" "$part_dev" > /dev/null || die

    nfo2 "Populating filesystem"
    cmd_mount vfat "$part_dev" || die

    for f in MLO u-boot.img uEnv.txt; do
        if [ -f "$cfg_sys_family/rootfs/boot/$f" ]; then
            nfo2 installing $f to boot partition
            cp "$cfg_sys_family/rootfs/boot/$f" mount || die
        fi
    done

    cmd_parted "$dev_loop" \
        set "$part_nr" lba on \
        || die

    cmd_parted "$dev_loop" print > /dev/null
}

create_part_rpiboot()
{
    nfo1 "RPi-Boot partition ($part_label)"

    nfo2 "Creating partition"
    cmd_parted "$dev_loop" \
        mkpart primary fat32 "$part_start" "$part_end" \
        set "$part_nr" boot on \
        align-check minimal "$part_nr" \
        || die

    nfo2 "Creating filesystem"
    $cmd_mkdosfs -n "$part_label" "$part_dev" > /dev/null || die

    nfo2 "Populating filesystem"
    cmd_mount vfat "$part_dev" || die

    for f in "$cfg_sys_family/rootfs/boot/"*; do
        nfo2 installing $f to boot partition
        cp -r "$f" mount || die
    done

    nfo2 renaming kernel to kernel7.img
    mv mount/kernel mount/kernel7.img

    if [ -f mount/board.dtb ]; then
        dtb=$(basename "$cfg_target_linux_dtb")
        nfo2 renaming board.dtb to "$dtb"
        mv "mount/board.dtb" "mount/$dtb"
    fi

    cmd_parted "$dev_loop" \
        set "$part_nr" lba on \
        || die

    cmd_parted "$dev_loop" print > /dev/null
}

create_part_root()
{
    nfo1 "Root partition ($part_label)"

    nfo2 "Creating partition"
    cmd_parted "$dev_loop" \
        mkpart primary ext2 "$part_start" "$part_end" \
        align-check minimal "$part_nr" \
        || die

    nfo2 "Creating filesystem"
    "$cmd_mkfs_ext2" -q -F -L "$part_label" "$part_dev" > /dev/null 2>&1 || die

    nfo2 "Populating filesystem"
    cmd_mount ext2 "$part_dev" || die
    tar -C mount -pxf "$cfg_rootfs_tar" || die

    # Install bootloader.
    if [ -f "$cfg_sys_family/toolchain/bin/extlinux" ]; then
        nfo2 "Installing extlinux to root partition"
        "$cfg_sys_family/toolchain/bin/extlinux" -S 63 -H 255 -i mount/boot/extlinux || die
    fi

    cmd_unmount || die

    # Mark partition bootable if needed.
    if [ -f "$cfg_sys_family/toolchain/bin/extlinux" ]; then
        cmd_parted "$dev_loop" \
            set "$part_nr" boot on \
            || die
    fi
}

create_part_data()
{
    nfo1 "Data partition ($part_label)"

    nfo2 "Creating partition"
    cmd_parted "$dev_loop" \
        mkpart primary ext4 "$part_start" "$part_end" \
        align-check minimal "$part_nr" \
        || die

    nfo2 "Creating filesystem"
    "$cmd_mkfs_ext4" -q -F -L "$part_label" -O dir_index "$part_dev" > /dev/null 2>&1 || die

    nfo2 "Populating filesystem"
    cmd_mount ext4 "$part_dev" || die
    mkdir mount/lsts || die
    cmd_unmount || die
}

export LC_ALL=C

if [ -z "$BASH_VERSION" ]; then
    echo "ERROR: you must use bash to run this script."
    exit 1
fi

if [ "$(whoami)" != 'root' ]; then
    echo "ERROR: you must be root to execute this target."
    exit 1
fi

if [ $# -lt 2 ]; then
    echo "Usage: $0 <config> <disk> [disk_size]"
    exit 1
fi

source "$1"

if ! [ -f "$cfg_rootfs_tar" ]; then
    echo "ERROR: you must run pkrootfs.bash first."
    exit 1
fi

if [ -x "$cfg_dir_toolchain/sbin/parted" ]; then
    cmd_parted="$cfg_dir_toolchain/sbin/parted"
else
    echo "Warning: using system parted, this might lead to errors"
    cmd_parted="parted"
fi

if [ -x "$cfg_dir_toolchain/sbin/fdisk" ]; then
    cmd_fdisk="$cfg_dir_toolchain/sbin/fdisk"
else
    echo "Warning: using system fdisk, this might lead to errors"
    cmd_fdisk="fdisk"
fi

if [ -x "$cfg_dir_toolchain/sbin/mkdosfs" ]; then
    cmd_mkdosfs="$cfg_dir_toolchain/sbin/mkdosfs"
else
    echo "Warning: using system mkdosfs, this might lead to errors"
    cmd_mkdosfs="mkdosfs"
fi

if [ -x "$cfg_dir_toolchain/sbin/mkfs.ext2" ]; then
    cmd_mkfs_ext2="$cfg_dir_toolchain/sbin/mkfs.ext2"
else
    echo "Warning: using system mkfs.ext2, this might lead to errors"
    cmd_mkfs_ext2="mkfs.ext2"
fi

if [ -x "$cfg_dir_toolchain/sbin/mkfs.ext4" ]; then
    cmd_mkfs_ext4="$cfg_dir_toolchain/sbin/mkfs.ext4"
else
    echo "Warning: using system mkfs.ext4, this might lead to errors"
    cmd_mkfs_ext4="mkfs.ext4"
fi

source "functions.bash"

dev="$2"

# unmounting partitions on target device
mounted_partition=$(mount | grep $dev  | cut -f1 -d " ");
if [ ${#mounted_partition} -gt 0 ]; then
    echo "Warning: some partitions of $hd_dev are mounted:"
    for p in ${mounted_partition};
    do
    echo "		unmounting $p";
    umount $p;
    done
fi

if [ -z "$cfg_partitions" ]; then
    cfg_partitions=( \
        'root' 'root0' '512B'  '532MiB'
        'data' 'data0' '532MiB' '-1'
    )
fi

cmd_loop_attach()
{
    export dev="$1"
    export dev_loop="$(losetup -f)"

    nfo1 "Attaching $dev to $dev_loop"
    losetup -v "$dev_loop" "$dev"
    if [ $? -ne 0 ]; then
        unset dev_loop
        die
    fi
}

cmd_loop_detach()
{
    nfo1 "Detaching $dev_loop"
    sync && sync && sync && sync
    blockdev --flushbufs "$dev_loop"
    losetup -v -d "$dev_loop"
    sync && sync && sync && sync
    unset dev_loop
}

nfo1 "Obliterating partition table"
cmd_loop_attach "$dev"
dd if=/dev/zero of="$dev_loop" bs=1 count=1M count=32 > /dev/null 2>&1 || die
losetup -a
cmd_loop_detach
losetup -a

nfo1 "Creating empty partition table"
cmd_loop_attach "$dev"
cmd_parted "$dev_loop" mklabel msdos || die
cmd_loop_detach

part_nr=1
xboot_system_id=0
for ((i = 0; i < ${#cfg_partitions[@]}; i += 4)); do
    cmd_loop_attach "$dev"

    part_type="${cfg_partitions[$i+0]}"
    part_label="${cfg_partitions[$i+1]}"
    part_start="${cfg_partitions[$i+2]}"
    part_end="${cfg_partitions[$i+3]}"
    part_dev="${dev_loop}p${part_nr}"

    case $part_type in
        'x-boot')
            create_part_xboot
            xboot_system_id=1
            ;;
        'rpi-boot')
            create_part_rpiboot
            xboot_system_id=1
            ;;
        'root')
            create_part_root
            ;;
        'data')
            create_part_data
            ;;
        *)
            echo "ERROR: unknown partition type '$part_type'"
            die
            ;;
    esac

    cmd_loop_detach
    let part_nr++
done

if [ -f "$cfg_sys_family/rootfs/boot/extlinux/mbr.bin" ]; then
    nfo1 "Installing bootloader in MBR..."
    cmd_loop_attach "$dev"
    dd if="$cfg_sys_family/rootfs/boot/extlinux/mbr.bin" of="$dev_loop" > /dev/null 2>&1
    cmd_loop_detach
fi

nfo1 "Synchronizing caches"
sync && sync && sync && sync && sync && sync

# Make sure the partition has 0x0e type.
if [ $xboot_system_id -eq 1 ]; then
    cmd_loop_attach "$dev"
    echo -en "t\n1\ne\nw\n" | $cmd_fdisk "$dev_loop" > /dev/null 2>&1
    cmd_loop_detach
fi
