version=\
(
    "1.0.2"
)

url=\
(
    "http://www.multiprecision.org/mpc/download/mpc-$version.tar.gz"
)

md5=\
(
    "68fadff3358fb3e7976c7a398a0af4c3"
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
