version=\
(
    "1.0"
)

url=\
(
    "http://ffmpeg.org/releases/ffmpeg-$version.tar.bz2"
)

md5=\
(
    3ed526cea20c1bffb5a37f7730f710bd
)

configure()
{
    ./configure \
        --sysroot="$cfg_dir_toolchain_sysroot" \
        --prefix="$cfg_dir_rootfs/usr" \
        --cross-prefix="$cfg_target_canonical-" \
        --target-os="linux" \
        --enable-memalign-hack \
        --enable-shared \
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
}
