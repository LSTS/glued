source $PKG_COMMON

requires=\
(
    'readline/default'
    'ncurses/default'
)

configure()
{
    cd "$pkg_build_dir" &&
    CFLAGS=-I"$cfg_dir_toolchain_sysroot/usr/include" \
	LDFLAGS=-L"$cfg_dir_toolchain_sysroot/usr/lib" \
        "../gdb-$version/configure" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --with-sysroot="$cfg_dir_toolchain_sysroot" \
        --disable-nls \
        --with-curses \
        --with-system-readline
}

build()
{
    $cmd_make -C "$pkg_build_dir"
}

host_install()
{
    $cmd_make -C "$pkg_build_dir" install
}

target_install()
{
    $cmd_target_strip \
        "$cfg_dir_toolchain_sysroot/usr/bin/gdb" \
        -o "$cfg_dir_rootfs/usr/bin/gdb" &&

    $cmd_target_strip \
        "$cfg_dir_toolchain_sysroot/usr/bin/gdbserver" \
        -o "$cfg_dir_rootfs/usr/bin/gdbserver"
}
