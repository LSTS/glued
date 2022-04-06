source "$pkg_common"

configure()
{
    $cmd_make distclean

    "../e2fsprogs-$version/configure" \
        --prefix="$cfg_dir_toolchain" \
        --disable-shared \
        --enable-static \
        --disable-nls
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}
