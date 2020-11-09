version=\
(
    '4.2'
)

url=\
(
    "http://ftp.gnu.org/gnu/make/make-$version.tar.bz2"
)

md5=\
(
    '85ad14d08766201ffe71efa866f4fb91'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
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
    cd "$cfg_dir_toolchain/bin" && ln -s make gmake
}
