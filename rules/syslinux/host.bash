source $pkg_common

host_install()
{
    $cmd_make_single clean &&
    $cmd_make_single CC="$cmd_target_cc" &&
    cp -d bios/extlinux/extlinux ${cfg_dir_toolchain}/bin &&
    mkdir -p ${cfg_dir_toolchain}/boot &&
    cp -d bios/mbr/mbr.bin ${cfg_dir_toolchain}/boot/mbr.bin
}
