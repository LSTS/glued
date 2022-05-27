maintainer=\
(
    'Pedro Gonçalves <pedro@fe.up.pt>'
)


target_install()
{
  mkdir -p $cfg_dir_builds/$pkg/rootfs/boot
  export cfg_dir_output_rootfs=$cfg_dir_builds/$pkg/rootfs
  $cmd_cp $pkg_dir/cfs/5uart/* ${cfg_dir_output_rootfs}/boot/

  tar -czf ../rpi4cfs-5uart.tar.gz ../rootfs
}
