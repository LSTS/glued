version=\
(
    '1.2.7'
)

url=\
(
    "http://downloads.sourceforge.net/project/libpng/zlib/$version/zlib-$version.tar.gz"
)

md5=\
(
    '60df6a37c56e7c1366cca812414f7b85'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
    make distclean

    ./configure \
        --shared \
        --prefix="$cfg_dir_toolchain"
}

build()
{
    $cmd_make -j1
}

host_install()
{
    $cmd_make -j1 install
}
