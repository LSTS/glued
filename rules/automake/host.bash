version=\
(
    '1.11.1'
)
url=\
(
    "http://ftp.gnu.org/gnu/automake/automake-$version.tar.bz2"
)

md5=\
(
    'c2972c4d9b3e29c03d5f2af86249876f'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'autoconf/host'
)

configure()
{
    "../automake-$version/configure" \
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
