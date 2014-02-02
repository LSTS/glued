version=\
(
    '1.2.6'
)

url=\
(
    "http://www.x.org/releases/X11R7.6/src/everything/xtrans-$version.tar.bz2"
)

md5=\
(
    'c66f9ffd2da4fb012220c6c40ebc7609'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
    "../xtrans-$version/configure" \
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
    $cmd_make install &&
    mv \
        "$cfg_dir_toolchain_sysroot/usr/share/pkgconfig/xtrans.pc" \
        "$cfg_dir_toolchain_sysroot/usr/lib/pkgconfig"
}
