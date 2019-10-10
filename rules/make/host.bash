version=\
(
    '3.82'
)

url=\
(
    "https://lsts.pt/glued/make-$version.tar.bz2"
)

md5=\
(
    '69520444a44561c8ce10276eee8ec55e'
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
