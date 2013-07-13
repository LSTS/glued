version=\
(
    "5.0.4"
)

url=\
(
    "ftp://ftp.gmplib.org/pub/gmp-$version/gmp-$version.tar.bz2"
)

md5=\
(
    "50c3edcb7c9438e04377ee9a1a061b79"
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
