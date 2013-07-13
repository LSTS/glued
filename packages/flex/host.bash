version=\
(
    "2.5.35"
)

url=\
(
    "http://downloads.sourceforge.net/flex/flex-${version}.tar.bz2"
)

md5=\
(
    "10714e50cea54dc7a227e3eddcd44d57"
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
    $cmd_make install
}
