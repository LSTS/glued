version=\
(
    '2.8.12'
)

url=\
(
    "http://prdownloads.sourceforge.net/wxwindows/wxGTK-$version.tar.gz"
)

md5=\
(
    'b12c78d947d89e1120443761f1b7693b'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'gtk+/default'
)

configure()
{
    export PKG_CONFIG_PATH="$cfg_dir_toolchain_sysroot/usr/lib/pkgconfig"

    "../wxGTK-$version/configure" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --prefix="$cfg_dir_toolchain_sysroot/usr"
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
    echo ""
}
