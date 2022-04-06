version=\
(
    "1.7.3.0"
)

url=\
(
    "http://www.dest-unreach.org/socat/download/socat-$version.tar.bz2"
)

md5=\
(
    "b607edb65bc6c57f4a43f06247504274"
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

post_unpack()
{
    patches=$(ls "$pkg_dir"/patches/*.patch)

    cd "../socat-$version"
    if [ -n "$patches" ]; then
        cat $patches | patch -p1
    fi
}

configure()
{
    export sc_cv_sys_crdly_shift=9
    export sc_cv_sys_tabdly_shift=11
    export sc_cv_sys_csize_shift=4
    export ac_cv_ispeed_offset=13
    "../socat-$version/configure" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --target=$cfg_target_canonical \
        --host=$cfg_target_canonical \
        --build=$cfg_host_canonical \
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
    $cmd_target_strip socat -o "$cfg_dir_rootfs/usr/bin/socat"
}
