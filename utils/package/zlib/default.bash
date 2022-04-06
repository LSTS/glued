source "$pkg_common"

configure()
{
    make distclean

    CC="$cmd_target_cc" \
        ./configure \
        --shared \
        --prefix="$cfg_dir_toolchain_sysroot/usr"
}

build()
{
    $cmd_make -j1
}

host_install()
{
    $cmd_make -j1 install
}

target_install()
{
    cp -a libz.so* "$cfg_dir_rootfs/lib"
    $cmd_target_strip "$cfg_dir_rootfs/lib/libz.so"*
}
