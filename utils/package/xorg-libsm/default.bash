version=\
(
    '1.2.0'
)

url=\
(
    "http://www.x.org/releases/X11R7.6/src/everything/libSM-$version.tar.bz2"
)

md5=\
(
    'e78c447bf1790552b644eca81b542742'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'xorg-libice/default'
    'xorg-xproto/default'
)

configure()
{
    "../libSM-$version/configure" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --disable-static \
        --enable-shared \
        --without-libuuid \
	--without-xmlto
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}
