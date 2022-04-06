version=\
(
    "1.1.26"
)

url=\
(
    "ftp://xmlsoft.org/libxml2/libxslt-$version.tar.gz"
)

md5=\
(
    "e61d0364a30146aaa3001296f853b2b9"
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

requires=\
(
    'libxml2/host'
)

configure()
{
    ./configure \
        --prefix="${cfg_dir_toolchain}" \
        --disable-shared \
        --enable-static
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make_single install
}
