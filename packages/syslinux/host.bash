source $PKG_COMMON

host_install()
{
    $cmd_make clean &&
    $cmd_make &&
    cp -d extlinux/extlinux ${cfg_dir_toolchain}/bin &&
    mkdir -p ${cfg_dir_toolchain}/boot &&
    cp -d mbr/mbr.bin ${cfg_dir_toolchain}/boot/mbr.bin
}
