source "$PKG_COMMON"

configure()
{
    cd "$pkg_build_dir" &&
    "../util-linux-$version/configure" \
        --prefix="$cfg_dir_toolchain" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --disable-wall \
        --disable-static \
        --enable-shared \
        --without-ncurses
}

build()
{
    $cmd_make -C $pkg_build_dir
}

target_install()
{
    $cmd_target_strip $pkg_build_dir/sys-utils/ldattach -o $cfg_dir_rootfs/usr/bin/ldattach
}
