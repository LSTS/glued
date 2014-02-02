version=\
(
    '2.03'
)

url=\
(
    "http://www.oberhumer.com/opensource/lzo/download/lzo-$version.tar.gz"
)

md5=\
(
    '0c3d078c2e8ea5a88971089a2f02a726'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
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
