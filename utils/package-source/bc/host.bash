version=\
(
    '1.06'
)

url=\
(
    "http://ftp.gnu.org/gnu/bc/bc-$version.tar.gz"
)

md5=\
(
    'd44b5dddebd8a7a7309aea6c36fda117'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'flex/host'
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
