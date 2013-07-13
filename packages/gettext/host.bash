version=\
(
    '0.18.1.1'
)

url=\
(
    "http://ftp.gnu.org/pub/gnu/gettext/gettext-$version.tar.gz"
)

md5=\
(
    '3dd55b952826d2b32f51308f2f91aa89'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
    "../gettext-$version/configure" \
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
