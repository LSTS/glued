source "$pkg_common"

configure()
{
    make distclean

    mkdir $cfg_dir_builds/$pkg/toolchain
    mkdir $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical
    mkdir $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot
    mkdir $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot/usr
    export cfg_dir_output_toolchain_sysroot=$cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot

    CC="$cmd_target_cc" \
        ./configure \
        --shared \
        --prefix="$cfg_dir_output_toolchain_sysroot/usr"
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
    mkdir $cfg_dir_builds/$pkg/rootfs
    mkdir $cfg_dir_builds/$pkg/rootfs/usr
    mkdir $cfg_dir_builds/$pkg/rootfs/usr/lib
    export cfg_dir_output_rootfs=$cfg_dir_builds/$pkg/rootfs/usr

    cp -a libz.so* "$cfg_dir_output_rootfs/lib"
    $cmd_target_strip "$cfg_dir_output_rootfs/lib/libz.so"*

    tar -czf ../zlib-v$version.tar.gz ../rootfs ../toolchain
}
