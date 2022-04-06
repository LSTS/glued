version=\
(
    '3.1.5'
)

url=\
(
    "http://www.mpfr.org/mpfr-$version/mpfr-$version.tar.bz2"
)

md5=\
(
    'b1d23a55588e3b2a13e3be66bc69fd8d'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'gmp/host'
)

configure()
{
    ./configure \
        --prefix="$cfg_dir_toolchain" \
        --with-gmp="$cfg_dir_toolchain" \
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
