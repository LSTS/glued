version=\
(
    "3.1.6"
)

url=\
(
    "http://ftp.gnu.org/gnu/gawk/gawk-$version.tar.bz2"
)

md5=\
(
    "c9926c0bc8c177cb9579708ce67f0d75"
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
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
