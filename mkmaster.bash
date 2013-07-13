#! /bin/bash
#############################################################################
# Copyright (C) 2007-2012 Laboratório de Sistemas e Tecnologia Subaquática  #
# Departamento de Engenharia Electrotécnica e de Computadores               #
# Rua Dr. Roberto Frias, 4200-465 Porto, Portugal                           #
#############################################################################
# Author: Ricardo Martins                                                   #
#############################################################################
# $Id:: mkmaster.bash 1370 2012-12-18 08:50:49Z rasm                      $:#
#############################################################################

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

hd_dev="$2"
hd_size="$3"
hd_sects=63
hd_heads=255
hd_sectorsize=512
fs1_blocksize=1024
fs2_blocksize=4096
log="master.log"

if [ ! -e "$cfg_sys_family" ]; then
    echo "ERROR: $cfg_sys_family system does not exist"
    exit 1
fi

detach()
{
    dev="$1"

    while [ 1 ]; do
        losetup -vd "$dev" >> "$log" 2>&1
        str="$(losetup -a 2>&1 | grep "$dev")"
        if [ -z "$str" ]; then
            echo "* Detached"
            break
        fi
        echo "* Detaching..."
        sync; sync; sync; sync
        sleep 1
    done
}

if [ -x "$cfg_sys_family/toolchain/sbin/fdisk" ]; then
    fdisk="$cfg_sys_family/toolchain/sbin/fdisk"
else
    echo "Warning: using system fdisk, this might lead to errors"
    fdisk="fdisk"
fi

echo "* Starting..." > "$log"

if [ -b "$hd_dev" ]; then
    hd_size=$($fdisk -l $hd_dev | grep ^Disk | head -n 1 | cut -f2 -d, | cut -f2 -d' ')
else
    if [ -z "$hd_size" ]; then
        echo "ERROR: disk_size is a mandatory argument for creating disk images."
        exit 1
    fi

    dd if=/dev/zero of="$hd_dev" bs=1 count=0 seek=$hd_size >> "$log" 2>&1
fi

# Compute number of cylinders.
hd_cyls=$[$hd_size/($hd_sectorsize*$hd_heads*$hd_sects)]

echo "* Searching for available loop device..."
hd_loop=$(losetup -f)

echo "* Attaching target device/image to loop device $hd_loop..."
losetup -v $hd_loop "$hd_dev" >> "$log" 2>&1

fdisk_args="-b $hd_sectorsize -C $hd_cyls -H $hd_heads -S $hd_sects $hd_loop"

echo "* Erasing first sectors."
dd if=/dev/zero of="$hd_loop" bs=1M count=32 >> "$log" 2>&1

echo "* Creating empty partition table."
(echo "o"; echo "w") | $fdisk $fdisk_args >> "$log" 2>&1

echo "* Creating root0 partition."
(echo "n"; echo "p"; echo "1"; echo ""; echo "+1024M"; echo "w") \
    | $fdisk $fdisk_args >> "$log" 2>&1

echo "* Marking root0 partition as bootable..."
(echo "a"; echo "1"; echo "w") \
    | $fdisk $fdisk_args >> "$log" 2>&1

echo "* Creating data0 partition."
(echo "n"; echo "p"; echo "2"; echo ""; echo ""; echo "w") \
    | $fdisk $fdisk_args >> "$log" 2>&1

hd1_start=$($fdisk -u -l $fdisk_args | grep "$hd_loop"p1 | awk '{print $3}')
hd1_end=$($fdisk -u -l $fdisk_args | grep "$hd_loop"p1 | awk '{print $4}')
hd2_start=$($fdisk -u -l $fdisk_args | grep "$hd_loop"p2 | awk '{print $2}')
hd2_end=$($fdisk -u -l $fdisk_args | grep "$hd_loop"p2 | awk '{print $3}')
hd1_offs=$[$hd1_start*$hd_sectorsize]
hd2_offs=$[$hd2_start*$hd_sectorsize]
hd1_size=$[($hd1_end*$hd_sectorsize)-$hd1_offs]
hd2_size=$[($hd2_end*$hd_sectorsize)-$hd2_offs]
fs1_blocks=$[$hd1_size/$fs1_blocksize]
fs2_blocks=$[$hd2_size/$fs2_blocksize]

# Create root0
echo "* Searching for available loop devices..."
hd1_loop=$(losetup -f)

echo "* Attaching root0 partition to loop device $hd1_loop..."
losetup -vo "$hd1_offs" "$hd1_loop" "$hd_dev" >> "$log" 2>&1

echo "* Creating root0 filesystem..."
mkfs.ext2 -b $fs1_blocksize -L root0 "$hd1_loop" "$fs1_blocks" >> "$log" 2>&1
tune2fs -c 0 "$hd1_loop" >> "$log" 2>&1

echo "* Populating root filesystem..."
mkdir -p mount && mount -t ext2 "$hd1_loop" mount &&
tar -C mount -pxf $cfg_sys_family/glued-*-$cfg_sys_name-rootfs.tar.bz2 &&
if [ -f "$cfg_sys_family/toolchain/bin/extlinux" ]; then
    echo "* Installing bootloader in root partition..."
    "$cfg_sys_family/toolchain/bin/extlinux" -S $hd_sects -H $hd_heads -i mount/boot/extlinux >> "$log" 2>&1
fi

while [ 1 ]; do
    umount mount && rmdir mount && break
    sleep 1
done

echo "* Detaching root0 partition from loop device $hd1_loop..."
detach "$hd1_loop"

# Create data0
echo "* Searching for available loop devices..."
hd2_loop=$(losetup -f)

echo "* Attaching data partition to loop device $hd2_loop..."
losetup -vo "$hd2_offs" "$hd2_loop" "$hd_dev" >> "$log" 2>&1

echo "* Creating data filesystem..."
mkfs.ext4 -b $fs2_blocksize -O sparse_super,dir_index -L data0 "$hd2_loop" "$fs2_blocks" >> "$log" 2>&1
mkdir mount && mount -t ext4 "$hd2_loop" mount && mkdir -p mount/lsts/{glued,dune} && umount mount && rmdir mount
blockdev --flushbufs "$hd2_loop"

echo "* Detaching data partition from loop device $hd2_loop..."
detach "$hd2_loop"

if [ -f "$cfg_sys_family/rootfs/boot/extlinux/mbr.bin" ]; then
    echo "* Installing bootloader in MBR..."
    dd if="$cfg_sys_family/rootfs/boot/extlinux/mbr.bin" of=$hd_loop >> "$log" 2>&1
fi

echo "* Detaching disk/image from loop device $hd_loop..."
detach $hd_loop
