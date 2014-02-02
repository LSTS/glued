version=\
(
    "1.03"
)

url=\
(
    "http://www.lzop.org/download/lzop-$version.tar.gz"
)

md5=\
(
    "006c5e27fb78cdd14a628fdfa5aa1905"
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

configure()
{
    CPPFLAGS="-I$cfg_dir_toolchain/include" \
        LDFLAGS="-L$cfg_dir_toolchain/lib" \
        ./configure \
        --prefix="$cfg_dir_toolchain" \
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
