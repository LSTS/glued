version=\
(
    '2.8'
)

url=\
(
    "https://github.com/martinh/libconfuse/releases/download/v$version/confuse-$version.tar.gz"
)

md5=\
(
    'e94ade0372a43e80b35031046bbc2a33'
)

maintainer=\
(
    'Ricardo Martins <rasm@oceanscan-mst.com>'
)

configure()
{
    export PKG_CONFIG="${cfg_dir_toolchain}/bin/pkg-config"
    export PKG_CONFIG_PATH="$cfg_dir_toolchain_sysroot/usr/lib/pkgconfig"
    "../confuse-$version/configure" \
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
    cp -a "$cfg_dir_toolchain_sysroot/usr/lib/libconfuse"*.so* "$cfg_dir_rootfs/lib" &&
    $cmd_target_strip "$cfg_dir_rootfs/lib/libconfuse"*.so*
}
