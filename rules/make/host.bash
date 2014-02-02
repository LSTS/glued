version=\
(
    '3.82'
)

url=\
(
    "http://ftp.gnu.org/gnu/make/make-$version.tar.bz2"
)

md5=\
(
    '1a11100f3c63fcf5753818e59d63088f'
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
