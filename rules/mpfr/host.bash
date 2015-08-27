version=\
(
    '3.1.3'
)

url=\
(
    "http://www.mpfr.org/mpfr-current/mpfr-$version.tar.bz2"
)

md5=\
(
    "5fdfa3cfa5c86514ee4a241a1affa138"
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

requires=\
(
    'gmp/host'
)

configure()
{
    ./configure \
        --prefix="${cfg_dir_toolchain}" \
        --with-gmp="${cfg_dir_toolchain}" \
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
