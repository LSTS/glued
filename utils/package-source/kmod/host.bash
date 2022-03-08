. "$pkg_common"

configure()
{
    make distclean

    ./configure \
        --prefix="$cfg_dir_toolchain"
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install &&
    ln -fs ../bin/kmod "$cfg_dir_toolchain/sbin/depmod"
}
