version=\
(
    "0.28"
)

url=\
(
    "http://pkgconfig.freedesktop.org/releases/pkg-config-$version.tar.gz"
)

md5=\
(
    "aa3c86e67551adc3ac865160e34a2a0d"
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

configure()
{
    ./configure \
        --prefix="${cfg_dir_toolchain}" \
        --disable-shared \
        --enable-static \
        --with-internal-glib
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}
