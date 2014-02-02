version=\
(
    "3.1.3"
)

url=\
(
    "http://www.antlr3.org/download/C/libantlr3c-$version.tar.gz"
)

md5=\
(
    "d57fdb095da1d53555cb36cfe28f332b"
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

configure()
{
    ../libantlr3c-$version/configure \
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
    $cmd_make install
}

target_install()
{
    $cmd_target_strip \
        -v \
        --strip-unneeded \
        -o "$cfg_dir_rootfs/usr/lib/libantlr3c.so" \
        "$cfg_dir_toolchain_sysroot/usr/lib/libantlr3c.so"
}
