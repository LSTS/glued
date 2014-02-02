source "$pkg_common"

configure()
{
    make distclean

    ./configure \
        --shared \
        --prefix="$cfg_dir_toolchain"
}

build()
{
    $cmd_make -j1
}

host_install()
{
    $cmd_make -j1 install
}
