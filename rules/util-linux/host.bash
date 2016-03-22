source "$pkg_common"

requires=\
(
    'termcap/host'
)

configure()
{
    cd "$pkg_build_dir" &&
    CFLAGS="-I$cfg_dir_toolchain/include" \
    "../util-linux-$version/configure" \
        --prefix="$cfg_dir_toolchain" \
        --disable-wall \
        --enable-static \
        --disable-shared \
        --without-ncurses
}

build()
{
    $cmd_make -C "$pkg_build_dir"
}

target_install()
{
    $cmd_make -C "$pkg_build_dir" install
}
