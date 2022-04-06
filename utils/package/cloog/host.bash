version=\
(
    '0.18.1'
)

url=\
(
    "ftp://gcc.gnu.org/pub/gcc/infrastructure/cloog-$version.tar.gz"
)

md5=\
(
    'e34fca0540d840e5d0f6427e98c92252'
)

maintainer=\
(
    'Ricardo Martins <rasm@oceanscan-mst.com>'
)

configure()
{
    "../cloog-$version/configure" \
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
