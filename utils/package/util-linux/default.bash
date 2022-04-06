source "$pkg_common"

requires=\
(
  'ncurses/default'
)

configure()
{
  ./configure                                 \
    --prefix="$cfg_dir_toolchain_sysroot/usr" \
    --build="${cfg_host_canonical}"           \
    --host="${cfg_target_canonical}"          \
    --disable-wall
}

build()
{
  $cmd_make
}

host_install()
{
  $cmd_make install
}

target_install()
{
  $cmd_cp    "${cfg_dir_toolchain_sysroot}/usr/lib/"libuuid.so* "${cfg_dir_rootfs}/usr/lib/"
  $cmd_cp    "${cfg_dir_toolchain_sysroot}/usr/lib/"libblkid.so* "${cfg_dir_rootfs}/usr/lib/"
  $cmd_cp    "${cfg_dir_toolchain_sysroot}/usr/lib/"libmount.so* "${cfg_dir_rootfs}/usr/lib/"

  # More to do with the tools in /usr/bin/
}
