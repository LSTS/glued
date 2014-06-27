source "$pkg_common"

configure()
{
    $cmd_make distclean

    export CC=$cmd_target_cc
    export CROSS_COMPILE=$cfg_target_canonical
    "../e2fsprogs-$version/configure" \
        --prefix="$cfg_dir_rootfs" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --disable-nls
}

build()
{
    $cmd_make
}

target_install()
{
    $cmd_target_strip --strip-unneeded ../e2fsprogs-$version/e2fsck/e2fsck -o $cfg_dir_rootfs/sbin/e2fsck &&
    $cmd_target_strip --strip-unneeded ../e2fsprogs-$version/misc/mke2fs -o $cfg_dir_rootfs/sbin/mke2fs &&
    $cmd_target_strip --strip-unneeded ../e2fsprogs-$version/misc/tune2fs -o $cfg_dir_rootfs/sbin/tune2fs
}
