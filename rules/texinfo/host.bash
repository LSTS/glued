version=\
(
    '5.1'
)

url=\
(
    "http://ftp.gnu.org/gnu/texinfo/texinfo-$version.tar.gz"
)

md5=\
(
    '54e250014fe698fb4832016158747c03'
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
