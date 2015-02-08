#!/bin/sh

export PATH=/bin

mount -t proc proc /proc
mount -t sysfs sysfs /sys
mount -t devtmpfs devtmpfs /dev

while [ 1 ]; do
    dev="$(ls /sys/class/mmc_host/mmc?/mmc?:0001/block)"

    if [ -n "$dev" ]; then
        mount -o ro "/dev/${dev}p2" /mnt && break
    fi

    usleep 100000
done

umount /sys /proc /dev
exec switch_root /mnt /sbin/init

echo "ERROR: failed to switch root"
exec /bin/sh
