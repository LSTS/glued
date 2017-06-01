version=\
(
    "2.6"
)

url=\
(
    "http://ffmpeg.org/releases/ffmpeg-$version.tar.bz2"
)

md5=\
(
    '5bf6097833a3fea6a9e51b0a456c6922'
)

configure()
{
    mkdir -p ../build
    ./configure \
        --sysroot="$cfg_dir_toolchain_sysroot" \
        --prefix="$cfg_dir_rootfs/usr" \
        --incdir="$cfg_dir_toolchain_sysroot/usr/include" \
        --enable-cross-compile \
        --cross-prefix="$cfg_target_canonical-" \
        --libdir="$cfg_dir_builds/ffmpeg/build" \
        --target-os="linux" \
        --enable-shared \
        --disable-static \
        --enable-pic \
        --enable-gpl \
        --arch=$cfg_architecture
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make \
	LIBDIR="$cfg_dir_toolchain_sysroot/usr/lib" \
        install-headers

    $cmd_make \
        install-libs
}

target_install()
{
    $cmd_make \
        install-libs

    $cmd_cp -r "$cfg_dir_builds/ffmpeg/build/"* "$cfg_dir_rootfs/usr/lib/"
    $cmd_cp -r "$cfg_dir_builds/ffmpeg/build/"* "$cfg_dir_toolchain_sysroot/usr/lib/"
}
