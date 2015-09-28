version=\
(
    '2.4.6'
)

url=\
(
    "http://ftpmirror.gnu.org/libtool/libtool-$version.tar.gz"
)

md5=\
(
    'addf44b646ddb4e3919805aa88fa7c5e'
)

maintainer=\
(
    "Ricardo Martins <rasm@oceanscan-mst.com>"
)

configure()
{
    "../libtool-$version/configure" \
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
