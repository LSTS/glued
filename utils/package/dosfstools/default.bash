source $pkg_common

build()
{
    CC="$cmd_target_cc" \
      $cmd_make \
      PREFIX="$cfg_dir_toolchain_sysroot/usr"
}

target_install()
{
    $cmd_target_strip --strip-unneeded "../dosfstools-$version/mkfs.fat" -o "$cfg_dir_rootfs/sbin/mkfs.fat" &&
    $cmd_target_strip --strip-unneeded "../dosfstools-$version/fsck.fat" -o "$cfg_dir_rootfs/sbin/fsck.fat" &&
    $cmd_target_strip --strip-unneeded "../dosfstools-$version/fatlabel" -o "$cfg_dir_rootfs/sbin/fatlabel" &&
    ln -fs mkfs.fat "$cfg_dir_rootfs/sbin/mkfs.vfat" &&
    ln -fs fsck.fat "$cfg_dir_rootfs/sbin/fsck.vfat"
}
