version=\
(
    '1.0.7'
)

url=\
(
    "http://www.x.org/releases/X11R7.6/src/everything/libICE-$version.tar.bz2"
)

md5=\
(
    'bb72a732b15e9dc25c3036559387eed5'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'xorg-xtrans/default'
    'xorg-xproto/default'
)

configure()
{
    "../libICE-$version/configure" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --disable-static \
        --enable-shared \
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
