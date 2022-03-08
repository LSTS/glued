version=\
(
    '6.1.2'
)

url=\
(
    "http://ftp.gnu.org/pub/gnu/gmp/gmp-$version.tar.bz2"
)

md5=\
(
    '8ddbb26dc3bd4e2302984debba1406a5'
)

maintainer=\
(
    'Ricardo Martins <rasm@oceanscan-mst.com>'
)

configure()
{
    ./configure \
        --prefix="$cfg_dir_toolchain" \
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
