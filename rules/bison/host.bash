version=\
(
    '2.7.1'
)

url=\
(
    "http://ftp.gnu.org/gnu/bison/bison-$version.tar.gz"
)

md5=\
(
    'f00906151ff9d2cb599cdeae36d902ee'
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
