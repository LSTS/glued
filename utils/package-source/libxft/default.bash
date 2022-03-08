version=\
(
    '2.3.1'
)

url=\
(
    "http://xorg.freedesktop.org/releases/individual/lib/libXft-$version.tar.bz2"
)

md5=\
(
    '78d64dece560c9e8699199f3faa521c0'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'fontconfig/default'
)

configure()
{
    export PKG_CONFIG_PATH="$cfg_dir_toolchain_sysroot/usr/lib/pkgconfig"

    "../libXft-$version/configure" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical"
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}
