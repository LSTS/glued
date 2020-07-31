maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

host_install()
{
  cp -rv $cfg_dir_toolchain/include/uuid $cfg_dir_toolchain_sysroot/usr/include/
  $cmd_cp $cfg_dir_toolchain/lib/libuuid* $cfg_dir_toolchain_sysroot/usr/lib/
}
