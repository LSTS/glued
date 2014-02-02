version=\
(
    '3.1.2'
)

url=\
(
    "http://www.mpfr.org/mpfr-current/mpfr-$version.tar.bz2"
)

md5=\
(
    "ee2c3ac63bf0c2359bf08fc3ee094c19"
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
