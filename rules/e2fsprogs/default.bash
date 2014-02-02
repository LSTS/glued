version=\
(
    '1.41.9'
)

url=\
(
    "http://downloads.sourceforge.net/e2fsprogs/e2fsprogs-$version.tar.gz"
)

md5=\
(
    '52f60a9e19a02f142f5546f1b5681927'
)

configure()
{
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
