version=\
(
    '2.5.1'
)

url=\
(
    "http://ftp.gnu.org/gnu/bison/bison-$version.tar.gz"
)

md5=\
(
    '8fedf916f1aa2c4a31441d8f8bbc603c'
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
