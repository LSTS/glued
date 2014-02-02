version=\
(
    "1.0.26"
)

url=\
(
    "http://alsa.cybermirror.org/lib/alsa-lib-${version}.tar.bz2"
)

md5=\
(
    "2dfa35d28471d721e592b616beedf965"
)

requires=\
(
    'ncurses/default'
)

configure()
{
    CC="$cmd_target_cc" ./configure \
        --prefix="/usr" \
        --with-configdir="/usr/share/alsa" \
        --build="$cfg_host_canonical" \
        --host="$cfg_target_canonical" \
        --disable-alsatest \
        --disable-python \
        --with-debug
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make DESTDIR="$cfg_dir_toolchain_sysroot" install
    sed "s%/usr/lib%$cfg_dir_toolchain_sysroot/usr/lib%g" "$cfg_dir_toolchain_sysroot/usr/lib/libasound.la" -i
}

target_install()
{
    cp -av \
        "$cfg_dir_toolchain_sysroot/usr/lib/alsa-lib" \
        "$cfg_dir_rootfs/usr/lib" &&

    cp -av \
        "$cfg_dir_toolchain_sysroot/usr/lib/libasound.so"* \
        "$cfg_dir_rootfs/usr/lib" &&

    cp -av \
        "$cfg_dir_toolchain_sysroot/usr/share/alsa" \
        "$cfg_dir_rootfs/usr/share/"
}
