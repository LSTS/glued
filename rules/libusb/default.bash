version=\
(
    '1.0.20'
)

url=\
(
    "http://downloads.sourceforge.net/libusb/libusb-$version.tar.bz2"
)

md5=\
(
    '1d4eb194eaaa2bcfbba28102768c7dbf'
)

maintainer=\
(
    'Ricardo Martins <rasm@oceanscan-mst.com>'
)

configure()
{
    export PKG_CONFIG="${cfg_dir_toolchain}/bin/pkg-config"
    export PKG_CONFIG_PATH="$cfg_dir_toolchain_sysroot/usr/lib/pkgconfig"
    "../libusb-$version/configure" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --disable-udev \
        --disable-static \
        --enable-shared
}

build()
{
    make
}

host_install()
{
    export PKG_CONFIG="${cfg_dir_toolchain}/bin/pkg-config"
    export PKG_CONFIG_PATH="$cfg_dir_toolchain_sysroot/usr/lib/pkgconfig"
    $cmd_make install
}

target_install()
{
    cp -a "$cfg_dir_toolchain_sysroot/usr/lib/libusb"*.so* "$cfg_dir_rootfs/lib" &&
    $cmd_target_strip "$cfg_dir_rootfs/lib/libusb"*.so*
}
