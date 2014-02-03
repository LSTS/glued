version=\
(
    '0.9.6'
)

url=\
(
    "http://www.x.org/releases/X11R7.6/src/everything/libXrender-$version.tar.bz2"
)

md5=\
(
    '3b3b7d076c2384b6c600c0b5f4ba971f'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'xorg-libx11/default'
    'renderproto/default'
)

configure()
{
    "../libXrender-$version/configure" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --disable-static \
        --enable-shared
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make PREFIX="$cfg_dir_toolchain_sysroot/usr" install
}
