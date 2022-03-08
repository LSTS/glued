version=\
(
    '2.29.0'
)

url=\
(
    "http://ftp.gnome.org/pub/gnome/sources/gdk-pixbuf/2.29/gdk-pixbuf-$version.tar.xz"
)

md5=\
(
    'd6cf71ec63ff1138dece341c0551bde3'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'libtiff/default'
    'libjpeg-turbo/default'
)

configure()
{
    export PKG_CONFIG_PATH="$cfg_dir_toolchain_sysroot/usr/lib/pkgconfig"

    "../gdk-pixbuf-$version/configure" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --enable-gio-sniffing=no
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}
