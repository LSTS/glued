version=\
(
    '4.0'
)

url=\
(
    "http://ftp.gnu.org/gnu/make/make-$version.tar.bz2"
)

md5=\
(
    '571d470a7647b455e3af3f92d79f1c18'
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
