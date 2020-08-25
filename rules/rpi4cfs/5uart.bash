maintainer=\
(
    'Pedro Gonçalves <pedro@fe.up.pt>'
)


target_install()
{
    $cmd_cp $pkg_dir/cfs/5uart/* ${cfg_dir_rootfs}/boot/
}
