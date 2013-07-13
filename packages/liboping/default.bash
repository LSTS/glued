version=\
(
    "1.6.2"
)

url=\
(
    "http://verplant.org/liboping/files/liboping-${version}.tar.bz2"
)

md5=\
(
    "64a6f31310093d2517cfe7f05aa011e0"
)

configure()
{
    ./configure                                     \
        ac_cv_func_malloc_0_nonnull=yes             \
        ac_cv_func_realloc_0_nonnull=yes            \
        --prefix="${cfg_dir_toolchain_sysroot}/usr" \
        --target="$cfg_target_canonical"            \
        --host="$cfg_target_canonical"              \
        --build="$cfg_host_canonical"               \
        --without-perl-bindings                     \
        --with-gnu-ld
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
  # Libs: 
  for f in "$cfg_dir_toolchain_sysroot/usr/lib/"liboping*.so*; do
    if [ -L "$f" ]; then
      $cmd_cp "$f" "$cfg_dir_rootfs/usr/lib"
    else
      $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
    fi
  done

  # Bins: 
  for f in "$cfg_dir_toolchain_sysroot/usr/bin/"{noping,oping}; do
    if [ -L "$f" ]; then
      $cmd_cp "$f" "$cfg_dir_rootfs/usr/bin"
    else
      $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/bin/$(basename "$f")"
    fi
  done
}


