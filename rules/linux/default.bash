version=\
(
    '3.14.63'
)

url=\
(
    "https://www.kernel.org/pub/linux/kernel/v3.x/linux-$version.tar.xz"
)

md5=\
(
    '6cf8a6b23849f47f511e0e46cfdb6392'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'bc/host'
    'kmod/host'
    'lz4/host'
)

# Major/Minor version.
linux_mm_version()
{
    echo "$version" | cut -f1-2 -d.
}

# Major/Minor/Patch version.
linux_mmp_version()
{
    echo "$version" | cut -f1 -d-
}

patches=(\
    $(ls -1 \
         "$pkg_dir/patches/$version/"*.patch \
         "$pkg_dir/patches/$(linux_mmp_version)/"*.patch \
         "$pkg_dir/patches/$(linux_mm_version)/"*.patch \
         "$cfg_dir_system/patches/linux/$version/"*.patch \
         "$cfg_dir_system/patches/linux/$(linux_mmp_version)/"*.patch \
         "$cfg_dir_system/patches/linux/$(linux_mm_version)/"*.patch \
         2> /dev/null | awk '!a[$0]++')
)


# Get configuration file.
linux_cfg_file()
{
    for f in "$version" "$(linux_mmp_version)" "$(linux_mm_version)"; do
        f="$cfg_dir_system/cfg/linux-$f.cfg"
        if [ -f "$f" ]; then
            echo "$f"
            return 0
        fi

        echo "Candidate kernel configuration file '$f' doesn't exist." 1>&2
    done

    echo "ERROR: failed to find a valid kernel configuration file." 1>&2
    return 1
}

post_unpack()
{
    n=0; while [ -n "${patches[$n]}" ]; do
             patch="${patches[$n]}"
             echo "* Applying $patch..."
             (ucat "$patch" | patch -p1) || return 1
             let n++
         done

    if [ -d "$cfg_dir_toolchain/firmware" ]; then
        tar -C "$cfg_dir_toolchain/firmware" -c -v -f - . | tar -C firmware -x -v -f -
    fi
}

refresh()
{
    for rule in configure build target_install; do
        if [ "$(linux_cfg_file)" -nt "$cfg_dir_builds/linux/$pkg_var/.$rule" ]; then
            rm "$cfg_dir_builds/linux/$pkg_var/.$rule"
        fi
    done
}

configure()
{
    $cmd_make \
        ARCH=${cfg_target_linux} \
        mrproper || return 1

    cfg="$(linux_cfg_file)"
    [ -n "$cfg" ] || return 1
    $cmd_cp "$cfg" .config || return 1

    if [ -f "$cfg_dir_system/files/initramfs_init.sh" ]; then
        $cmd_mkdir initramfs &&
        $cmd_cp "$pkg_dir/files/initramfs.conf" . &&
        $cmd_cp "$cfg_dir_system/files/initramfs_init.sh" initramfs/init.sh &&
        $cmd_cp "$cfg_dir_rootfs/bin/busybox" initramfs/busybox
    fi

    yes '' | $cmd_make \
        CROSS_COMPILE=${cfg_target_canonical}- \
        ARCH=${cfg_target_linux} \
        oldconfig
}

build()
{
    $cmd_make \
        CROSS_COMPILE=$cfg_target_canonical- \
        ARCH=$cfg_target_linux &&
    $cmd_make \
        CROSS_COMPILE=$cfg_target_canonical- \
        ARCH=$cfg_target_linux \
        modules &&

    if [ "$(basename $cfg_target_linux_kernel)" = 'uImage' ]; then
        $cmd_make \
            CROSS_COMPILE=$cfg_target_canonical- \
            ARCH=$cfg_target_linux \
            uImage
    fi

    # Compressed image.
    if [ "$(basename $cfg_target_linux_kernel)" = 'zImage' ]; then
        $cmd_make \
            CROSS_COMPILE=$cfg_target_canonical- \
            ARCH=$cfg_target_linux \
            zImage
    fi

    # Device tree blob.
    if [ -n "$cfg_target_linux_dtb" ]; then
        $cmd_make \
            CROSS_COMPILE=$cfg_target_canonical- \
            ARCH=$cfg_target_linux \
            dtbs
    fi

    if [ -n "${cfg_target_linux_size}" ]; then
        dd if="$cfg_target_linux_kernel" of="${cfg_target_linux_kernel}.padded" \
            ibs="${cfg_target_linux_size}" conv=sync &&
        mv "${cfg_target_linux_kernel}.padded" "${cfg_target_linux_kernel}"
    fi
}

host_install()
{
    # Device tree blobs.
    if [ -n "$cfg_target_linux_dtb" ]; then
        $cmd_mkdir "$cfg_dir_toolchain/boot" &&
            cp -v "$(dirname $cfg_target_linux_dtb)/"*.dtb "$cfg_dir_toolchain/boot"
    fi
}

target_install()
{
    if [ -n "$(file "$cfg_target_linux_kernel" | grep ELF)" ]; then
        strip="$(echo $cfg_dir_toolchain/bin/*-strip)"
        $strip -s -R .comment "$cfg_target_linux_kernel"
    fi

    # Kernel image.
    if [ -n "$cfg_target_linux_kernel" ]; then
        cp -v "$cfg_target_linux_kernel" "$cfg_dir_rootfs/boot/kernel"
    else
        echo "ERROR: failed to find kernel image at '$cfg_target_linux_kernel'"
        return 1
    fi

    $cmd_make \
        CROSS_COMPILE="$cfg_target_canonical-" \
        ARCH="$cfg_target_linux" \
        INSTALL_MOD_PATH="$cfg_dir_rootfs/usr" \
        modules_install

    $cmd_make \
        CROSS_COMPILE="$cfg_target_canonical-" \
        ARCH="$cfg_target_linux" \
        INSTALL_MOD_PATH="$cfg_dir_rootfs/usr" \
        firmware_install
}
