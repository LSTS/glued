version=\
(
    "1.7.2.1"
)

url=\
(
    "http://www.lsts.pt/glued/socat-$version.tar.bz2"
)

md5=\
(
    "7ddfea7e9e85f868670f94d3ea08358b"
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

configure()
{
    export sc_cv_sys_crdly_shift=9
    export sc_cv_sys_tabdly_shift=11
    export sc_cv_sys_csize_shift=4
    export ac_cv_ispeed_offset=13
    ../socat-$version/configure \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
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
    $cmd_make install
}

target_install()
{
    $cmd_target_strip socat -o "$cfg_dir_rootfs/usr/bin/socat"
}
