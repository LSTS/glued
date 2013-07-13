version=\
(
    "2.07"
)

url=\
(
    "http://www.nasm.us/pub/nasm/releasebuilds/$version/nasm-$version.tar.bz2"
)

md5=\
(
    "d8934231e81874c29374ddef1fbdb1ed"
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
    ./configure \
        --prefix="$cfg_dir_toolchain"
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}
