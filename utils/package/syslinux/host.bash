source $pkg_common

host_install()
{
    mkdir -p $cfg_dir_builds/$pkg/toolchain/bin
    export cfg_dir_output_toolchain=$cfg_dir_builds/$pkg/toolchain

    $cmd_make clean &&
    $cmd_make &&
    cp -d extlinux/extlinux ${cfg_dir_output_toolchain}/bin &&
    mkdir -p ${cfg_dir_output_toolchain}/boot &&
    cp -d mbr/mbr.bin ${cfg_dir_output_toolchain}/boot/mbr.bin

    tar -czf ../syslinux-v$version-host.tar.gz ../toolchain
}
