source "$pkg_common"

configure()
{
    mkdir $cfg_dir_builds/$pkg/rootfs
    mkdir $cfg_dir_builds/$pkg/rootfs/sbin
    export cfg_dir_output_rootfs=$cfg_dir_builds/$pkg/rootfs

    $cmd_make distclean

    export CC=$cmd_target_cc
    export CROSS_COMPILE=$cfg_target_canonical
    "../e2fsprogs-$version/configure" \
        --prefix="$cfg_dir_output_rootfs" \
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
    $cmd_target_strip --strip-unneeded ../e2fsprogs-$version/e2fsck/e2fsck -o "$cfg_dir_output_rootfs/sbin/e2fsck" &&
    $cmd_target_strip --strip-unneeded ../e2fsprogs-$version/misc/mke2fs -o "$cfg_dir_output_rootfs/sbin/mke2fs" &&
    $cmd_target_strip --strip-unneeded ../e2fsprogs-$version/misc/tune2fs -o "$cfg_dir_output_rootfs/sbin/tune2fs" &&
    ln -fs e2fsck "$cfg_dir_output_rootfs/sbin/fsck.ext2" &&
    ln -fs e2fsck "$cfg_dir_output_rootfs/sbin/fsck.ext3" &&
    ln -fs e2fsck "$cfg_dir_output_rootfs/sbin/fsck.ext4" &&
    ln -fs mke2fs "$cfg_dir_output_rootfs/sbin/mkfs.ext2" &&
    ln -fs mke2fs "$cfg_dir_output_rootfs/sbin/mkfs.ext3" &&
    ln -fs mke2fs "$cfg_dir_output_rootfs/sbin/mkfs.ext4"

    tar -czf ../e2fsprogs-v$version.tar.gz ../rootfs
}
