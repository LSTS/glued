version=\
(
    "2.5.2"
)

url=\
(
    "http://sourceforge.net/projects/freetype/files/ftjam/$version/ftjam-$version.tar.bz2"
)

md5=\
(
    "e61304b370ba06f68082f0219a196576"
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

requires=\
(
    'bison/host'
)

build()
{
    $cmd_make CC="$cmd_target_cc"
}

configure()
{
    ../ftjam-$version/configure \
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
