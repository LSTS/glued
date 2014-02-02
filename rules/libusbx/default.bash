version=\
(
    '1.0.12'
)

url=\
(
    "http://downloads.sourceforge.net/libusbx/libusbx-$version.tar.bz2"
)

md5=\
(
    'c41352ac755c7992edfcbb2ea4ad1349'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
    export PKG_CONFIG="${cfg_dir_toolchain}/bin/pkg-config"
    export PKG_CONFIG_PATH="$cfg_dir_toolchain_sysroot/usr/lib/pkgconfig"
    "../libusbx-$version/configure" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --disable-static \
        --enable-shared
}

build()
{
    $cmd_make
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
