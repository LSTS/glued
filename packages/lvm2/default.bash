source $pkg_common

configure()
{
  cd "../LVM2.${version}"
  ./configure \
    --prefix="${cfg_dir_toolchain_sysroot}/usr" \
    --build="${cfg_host_canonical}"             \
    --host="${cfg_target_canonical}"
}

build()
{
  cd "../LVM2.${version}"
  
  export ac_cv_func_malloc_0_nonnull=yes
  export ac_cv_func_realloc_0_nonnull=yes

  # Configuration is buggy so we have to do this...
  export CC="$cfg_target_canonical-gcc"
  export CXX="$cfg_target_canonical-g++"
  export AR="$cfg_target_canonical-ar"
  export RANLIB="$cfg_target_canonical-ranlib"

  $cmd_make
}

host_install()
{
  cd "../LVM2.${version}"
  sed "s#\$(confdir)/\$(CONFDEST)#${cfg_dir_toolchain_sysroot}\$(confdir)/\$(CONFDEST)#g" "doc/Makefile" -i
  $cmd_make install
}


target_install()
{
  $cmd_mkdir "${cfg_dir_rootfs}/etc/lvm"
  $cmd_cp    "${cfg_dir_toolchain_sysroot}/etc/lvm" "${cfg_dir_rootfs}/etc/lvm"
  $cmd_cp    "${cfg_dir_toolchain_sysroot}/usr/lib/"libdevmapper* "${cfg_dir_rootfs}/usr/lib"
  # More to be done.
}
