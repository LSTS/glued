version=\
(
    "1.0.5"
)

url=\
(
    "http://www.x.org/releases/X11R7.6/src/everything/kbproto-${version}.tar.bz2"
)

md5=\
(
    "e7edb59a3f54af15f749e8f3e314ee62"
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

configure()
{
    ../kbproto-$version/configure \
        --prefix="${cfg_dir_toolchain_sysroot}/usr" \
        --disable-static \
        --enable-shared \
        --target=$cfg_target_canonical \
        --host=$cfg_target_canonical \
        --build=$cfg_host_canonical
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make PREFIX="$cfg_dir_toolchain_sysroot/usr" install
}
