version=\
(
    2.6
)

revision=\
(
    1
)

url=\
(
    http://ftp.gnu.org/gnu/patch/patch-$version.tar.bz2
)

md5=\
(
    5729b1430ba6c2216e0f3eb18f213c81
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
