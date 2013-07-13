version=\
(
    "2.7.8"
)

url=\
(
    "ftp://xmlsoft.org/libxml2/libxml2-$version.tar.gz"
)

md5=\
(
    "8127a65e8c3b08856093099b52599c86"
)

configure()
{
    ../libxml2-$version/configure \
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
    $cmd_make install
}
