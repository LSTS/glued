version=\
(
    '2.4.12'
)

url=\
(
    "http://downloads.sourceforge.net/project/freetype/freetype2/$version/freetype-$version.tar.bz2"
)

md5=\
(
    '3463102764315eb86c0d3c2e1f3ffb7d'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
    "../freetype-$version/configure" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical"
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}
