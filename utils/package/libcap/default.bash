version=\
(
    '2.24'
)

url=\
(
    "https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-$version.tar.xz"
)

md5=\
(
    'd43ab9f680435a7fff35b4ace8d45b80'
)

maintainer=\
(
    'Ricardo Martins <rasm@oceanscan-mst.com>'
)

post_unpack()
{
    patches=$(ls "$pkg_dir"/patches/*.patch)

    cd ../libcap-$version
    if [ -n "$patches" ]; then
        cat $patches | patch -p1
    fi
}

build()
{
    $cmd_make \
        -C "../libcap-$version/libcap" \
        CC="$cmd_target_cc" \
        LIBATTR=no
}

host_install()
{
    $cmd_make \
        -C "../libcap-$version/libcap" \
        LIBATTR=no \
        prefix="$cfg_dir_toolchain_sysroot/usr" \
        DESTDIR="$cfg_dir_toolchain_sysroot/usr" \
        inc_prefix="$cfg_dir_toolchain_sysroot/usr" \
        INCDIR="$cfg_dir_toolchain_sysroot/usr/include" \
        lib_prefix="$cfg_dir_toolchain_sysroot/usr" \
        LIBDIR="$cfg_dir_toolchain_sysroot/usr/lib" \
        PKGCONFIGDIR="$cfg_dir_toolchain_sysroot/usr/lib/pkgconfig" \
        install &&

        deps="$(grep Libs.private "$cfg_dir_toolchain_sysroot/usr/lib/pkgconfig/libcap.pc" | cut -f2- -d:)"

        sed -e "s,@prefix@,$cfg_dir_toolchain_sysroot/usr," \
            -e 's,@exec_prefix@,${prefix}/bin,' \
            -e 's,@libdir@,${prefix}/lib,' \
            -e 's,@includedir@,${prefix}/include,' \
            -e "s,@VERSION@,$version," \
            -e "s,@deps@,$deps," \
            "../libcap-$version/libcap/libcap.pc.in" > "$cfg_dir_toolchain_sysroot/usr/lib/pkgconfig/libcap.pc"
}

target_install()
{
    cp -a "$cfg_dir_toolchain_sysroot/usr/lib/libcap"*.so* "$cfg_dir_rootfs/lib" &&
    $cmd_target_strip "$cfg_dir_rootfs/lib/libcap"*.so*
}
