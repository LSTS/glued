version=\
(
    '0.12.2'
)

url=\
(
    "ftp://gcc.gnu.org/pub/gcc/infrastructure/isl-$version.tar.bz2"
)

md5=\
(
    'e039bfcfb6c2ab039b8ee69bf883e824'
)

maintainer=\
(
    'Ricardo Martins <rasm@oceanscan-mst.com>'
)

configure()
{
    "../isl-$version/configure" \
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
    $cmd_make install-strip
}
