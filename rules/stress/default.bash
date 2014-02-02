version=\
(
    "1.0.4"
)

url=\
(
    "http://www.lsts.pt/glued/stress-${version}.tar.gz"
)

md5=\
(
    "a607afa695a511765b40993a64c6e2f4"
)

configure()
{
    ../stress-$version/configure \
        --prefix="${cfg_dir_toolchain_sysroot}/usr" \
        --target=$cfg_target_canonical \
        --host=$cfg_target_canonical
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
    cp "${cfg_dir_toolchain_sysroot}/usr/bin/stress" "${cfg_dir_rootfs}/usr/bin/"
}
