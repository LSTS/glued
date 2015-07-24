source $pkg_common

requires=\
(
    'ncurses/host'
)

configure()
{
    cd "$pkg_build_dir" &&
        LDFLAGS="-static -L$cfg_dir_toolchain/lib" \
        CFLAGS="-I$cfg_dir_toolchain/include" \
       "../gdb-$version/configure" \
        --prefix="$cfg_dir_toolchain" \
        --target="$cfg_target_canonical" \
        --host="$cfg_host_canonical" \
        --build="$cfg_host_canonical" \
        --with-build-sysroot="$cfg_dir_toolchain_sysroot" \
        --with-sysroot="$cfg_dir_toolchain_sysroot" \
        --disable-nls \
        --disable-tui
}

build()
{
    $cmd_make -C "$pkg_build_dir"
}

host_install()
{
    $cmd_make -C "$pkg_build_dir" install
}
