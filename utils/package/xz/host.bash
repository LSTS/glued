version=\
(
    '5.0.4'
)

url=\
(
    "http://tukaani.org/xz/xz-$version.tar.bz2"
)

md5=\
(
    '741cd3a5f64b23b7bac56ec5b2258715'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
    ./configure \
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
