source "$pkg_dir/default.bash"

host_install()
{
    $cmd_mkdir ${cfg_dir_rootfs}/../boot/
    $cmd_cp u-boot.bin ${cfg_dir_rootfs}/../boot/
}

target_install()
{
    echo "using dummy 'target_install'."
}
