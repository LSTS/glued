version=\
(
    '0.18.3.1'
)

url=\
(
    "http://ftp.gnu.org/pub/gnu/gettext/gettext-$version.tar.gz"
)

md5=\
(
    '3fc808f7d25487fc72b5759df7419e02'
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
