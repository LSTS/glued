version=\
(
    '4.1.0'
)

url=\
(
    "http://ftp.gnu.org/gnu/gawk/gawk-$version.tar.xz"
)

md5=\
(
    'b18992ff8faf3217dab55d2d0aa7d707'
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
