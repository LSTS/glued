. "$pkg_common"

configure()
{
    make distclean

    ./configure \
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
    cp -a "$cfg_dir_toolchain_sysroot/usr/lib/libkmod"*.so* "$cfg_dir_rootfs/lib" &&
        $cmd_target_strip "$cfg_dir_rootfs/lib/libkmod"*.so*
}
