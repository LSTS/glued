version=\
(
    "10.1"
)

url=\
(
    "http://libav.org/releases/libav-$version.tar.gz"
)

md5=\
(
    99c123b9ba9c0ff8c6bfd67a635f99ac
)

configure()
{
    mkdir -p $cfg_dir_builds/$pkg/rootfs/usr
    export cfg_dir_output_rootfs=$cfg_dir_builds/$pkg/rootfs

    ./configure \
        --sysroot="$cfg_dir_toolchain_sysroot" \
        --prefix="$cfg_dir_output_rootfs/usr" \
        --cross-prefix="$cfg_target_canonical-" \
        --target-os="linux" \
        --enable-memalign-hack \
        --enable-shared \
        --enable-pic \
        --enable-gpl \
        --arch=$cfg_architecture
}

build()
{
    $cmd_make
}

target_install()
{
    $cmd_make \
        install

    tar -czf ../libav-v$version.tar.gz ../rootfs
}
