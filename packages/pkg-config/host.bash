version=\
(
    "0.25"
)

url=\
(
    "http://pkgconfig.freedesktop.org/releases/pkg-config-$version.tar.gz"
)

md5=\
(
    "a3270bab3f4b69b7dc6dbdacbcae9745"
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
        --enable-static
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}
