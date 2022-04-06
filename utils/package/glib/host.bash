version=\
(
    '2.32.4'
)

url=\
(
    "http://ftp.gnome.org/pub/gnome/sources/glib/2.32/glib-$version.tar.xz"
)

md5=\
(
    'bf84fefd9c1a5b5a7a38736f4ddd674a'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'libffi/host'
    'gettext/host'
    'zlib/host'
    'python_host/host'
)

configure()
{
    PKG_CONFIG_PATH="$cfg_dir_toolchain/lib/pkgconfig" \
        "./configure" \
        --prefix="$cfg_dir_toolchain"
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}
