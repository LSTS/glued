version=\
(
    '1.0.9'
)

url=\
(
    "http://www.x.org/releases/X11R7.6/src/everything/libXt-$version.tar.bz2"
)

md5=\
(
    '8a414f8f2327aaa616ca2dcac1f5d8c3'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'xorg-xproto/default'
    'xorg-kbproto/default'
    'xorg-libice/default'
    'xorg-libx11/default'
    'xorg-libsm/default'
)

configure()
{
    "../libXt-$version/configure" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
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
