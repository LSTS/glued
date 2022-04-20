source $pkg_common

build()
{
    mkdir -p $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot/usr
    export cfg_dir_output_toolchain_sysroot=$cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot
    CC="$cmd_target_cc" \
      $cmd_make \
      PREFIX="$cfg_dir_output_toolchain_sysroot/usr"
}

target_install()
{
    mkdir -p $cfg_dir_builds/$pkg/rootfs/sbin
    export cfg_dir_output_rootfs=$cfg_dir_builds/$pkg/rootfs

    $cmd_target_strip --strip-unneeded "../dosfstools-$version/mkfs.fat" -o "$cfg_dir_output_rootfs/sbin/mkfs.fat" &&
    $cmd_target_strip --strip-unneeded "../dosfstools-$version/fsck.fat" -o "$cfg_dir_output_rootfs/sbin/fsck.fat" &&
    $cmd_target_strip --strip-unneeded "../dosfstools-$version/fatlabel" -o "$cfg_dir_output_rootfs/sbin/fatlabel" &&
    ln -fs mkfs.fat "$cfg_dir_output_rootfs/sbin/mkfs.vfat" &&
    ln -fs fsck.fat "$cfg_dir_output_rootfs/sbin/fsck.vfat"

    tar -czf ../dosfstools-v$version.tar.gz ../rootfs
}
