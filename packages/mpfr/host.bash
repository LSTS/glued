version=\
(
    '3.1.4'
)

url=\
(
    "http://www.mpfr.org/mpfr-current/mpfr-$version.tar.bz2"
)

md5=\
(
    "b8a2f6b0e68bef46e53da2ac439e1cf4"
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
