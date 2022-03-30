version=\
(
    "v0.29.2"
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/gcc-5.4/pkg-config-${version}-host.tar.gz"
)

md5=\
(
    "f6e931e319531b736fadc017f470e68a"
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
