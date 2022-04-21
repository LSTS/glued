source $pkg_common

host_install()
{
    mkdir -p $cfg_dir_builds/$pkg/toolchain/bin/
    export cfg_dir_output_toolchain=$cfg_dir_builds/$pkg/toolchain

    $cmd_make clean &&
    $cmd_make &&
    cp -d extlinux/extlinux ${cfg_dir_output_toolchain}/bin/extlinux
}

target_install()
{
    mkdir -p $cfg_dir_builds/$pkg/rootfs/boot
    mkdir -p $cfg_dir_builds/$pkg/rootfs/usr/sbin
    export cfg_dir_output_rootfs=$cfg_dir_builds/$pkg/rootfs

    if [ -n "$cfg_terminal" ]; then
        cfg_kernel_extra_args="$cfg_kernel_extra_args console=$cfg_terminal,115200"
        port="$(echo $cfg_terminal | sed 's/ttyS//g')"
        console="SERIAL $port 115200"
    fi

    if [ -z "$cfg_kernel_boot_dev" ]; then
        export cfg_kernel_boot_dev='/dev/sda1'
    fi

    $cmd_make clean &&
    $cmd_make CC="$cmd_target_cc" &&
    $cmd_target_strip extlinux/extlinux -o $cfg_dir_output_rootfs/usr/sbin/extlinux &&
    $cmd_mkdir $cfg_dir_output_rootfs/boot/extlinux &&
    cp -d mbr/mbr.bin $cfg_dir_output_rootfs/boot/extlinux &&
    (echo $console ; cat "$pkg_dir"/extlinux.conf) \
         | sed "s%\$cfg_kernel_extra_args%$cfg_kernel_extra_args%g" \
         | sed "s%\$cfg_kernel_boot_dev%$cfg_kernel_boot_dev%g" \
         >  "$cfg_dir_output_rootfs/boot/extlinux/extlinux.conf"

    tar -czf ../syslinux-v$version.tar.gz ../rootfs ../toolchain
}
