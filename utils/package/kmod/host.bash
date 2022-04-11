. "$pkg_common"

configure()
{
    mkdir $cfg_dir_builds/$pkg/toolchain
    mkdir $cfg_dir_builds/$pkg/toolchain/sbin
    export cfg_dir_output_toolchain=$cfg_dir_builds/$pkg/toolchain
    make distclean

    ./configure \
        --prefix="$cfg_dir_output_toolchain"
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install &&
    ln -fs ../bin/kmod "$cfg_dir_output_toolchain/sbin/depmod"
    tar -czf ../kmod-v$version-host.tar.gz ../toolchain
}
