version=\
(
    '1.12.2'
)

url=\
(
    "http://www.lsts.pt/glued/fakeroot_$version.tar.gz"
)

md5=\
(
    '1eb7d972a19159035892e7d132602726'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
    "../fakeroot-$version/configure" \
        --prefix="$cfg_dir_toolchain" \
        --disable-static \
        --enable-shared
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}
