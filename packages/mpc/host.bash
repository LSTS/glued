version=\
(
    "0.9"
)

url=\
(
    "http://www.multiprecision.org/mpc/download/mpc-$version.tar.gz"
)

md5=\
(
    "0d6acab8d214bd7d1fbbc593e83dd00d"
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

requires=\
(
    'mpfr/host'
    'gmp/host'
)

configure()
{
    ./configure \
        --prefix="${cfg_dir_toolchain}" \
        --with-gmp="${cfg_dir_toolchain}" \
        --with-mpfr="${cfg_dir_toolchain}" \
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
