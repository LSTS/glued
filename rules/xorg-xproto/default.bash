version=\
(
    "7.0.20"
)

url=\
(
    "http://www.x.org/releases/X11R7.6/src/everything/xproto-$version.tar.bz2"
)

md5=\
(
    "65633168e5315c19defb4652cd3d83c1"
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

configure()
{
    ../xproto-$version/configure \
        --prefix="${cfg_dir_toolchain_sysroot}/usr" \
        --disable-static \
        --enable-shared \
        --target=$cfg_target_canonical \
        --host=$cfg_target_canonical \
        --build=$cfg_host_canonical \
        --without-xmlto
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make PREFIX="$cfg_dir_toolchain_sysroot/usr" install
}
