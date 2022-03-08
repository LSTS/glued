version=\
(
    '1.34.1'
)

url=\
(
    "http://ftp.gnome.org/pub/GNOME/sources/pango/1.34/pango-$version.tar.xz"
)

md5=\
(
    'e36dc70c0e246db84b41736a40edf7a0'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'cairo/default'
)

configure()
{
    export PKG_CONFIG_PATH="$cfg_dir_toolchain_sysroot/usr/lib/pkgconfig"

    ./configure \
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
