# Package is buggy VLC does not work properly on target.

version=\
(
    "1.0.6"
)

url=\
(
    "http://download.videolan.org/pub/videolan/vlc/$version/vlc-${version}.tar.bz2"
)

md5=\
(
    "246a3865ec037f8f5757ef6b973a80fc"
)

requires=\
(
    'x264/default'
    'v4l-utils/default'
    'ffmpeg/default'
)

configure()
{
    export CC="$cmd_target_cc"
    ./configure \
        --prefix="${cfg_dir_toolchain_sysroot}/usr" \
        --build="$cfg_host_canonical"    \
        --host="$cfg_target_canonical"   \
        --enable-run-as-root             \
        --disable-dbus-control           \
        --disable-dbus                   \
        --disable-hal                    \
        --disable-mad                    \
        --disable-avcodec                \
        --disable-avformat               \
        --disable-swscale                \
        --disable-postproc               \
        --disable-a52                    \
        --disable-libmpeg2               \
        --disable-qt4                    \
        --disable-skins2                 \
        --disable-lua                    \
        --disable-x11                    \
        --disable-glx
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}

target_install()
{
    # Bins:
    for f in "$cfg_dir_toolchain_sysroot/usr/bin/"*vlc*; do
        if [ -L "$f" ]; then
            $cmd_cp "$f" "$cfg_dir_rootfs/usr/bin"
        else
            $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/bin/$(basename "$f")"
        fi
    done

    # Scripts:
    echo "#! /bin/sh
exec /usr/bin/vlc -I \"dummy\" \"$@\"" > "$cfg_dir_rootfs/usr/bin/cvlc"
    chmod 755 "$cfg_dir_rootfs/usr/bin/cvlc"
    echo "#! /bin/sh
exec /usr/bin/vlc -I \"rc\" \"$@\"" > "$cfg_dir_rootfs/usr/bin/rvlc"
    chmod 755 "$cfg_dir_rootfs/usr/bin/rvlc"

    # Libs:
    for f in "$cfg_dir_toolchain_sysroot/usr/lib/"lib*vlc*.so*; do
        if [ -L "$f" ]; then
            cp -av "$f" "$cfg_dir_rootfs/usr/lib"
        else
            $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
        fi
    done

    # Libs in in vlc folder:
    $cmd_cp "$cfg_dir_toolchain_sysroot/usr/lib/vlc/" "$cfg_dir_rootfs/usr/lib"
}
