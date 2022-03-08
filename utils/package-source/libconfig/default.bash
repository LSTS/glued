version=\
(
  "1.4.9"
)

url=\
(
  "http://www.hyperrealm.com/libconfig/libconfig-${version}.tar.gz"
)

md5=\
(
  "b6ee0ce2b3ef844bad7cac2803a90634"
)

configure()
{
  ./configure \
    --prefix="${cfg_dir_toolchain_sysroot}/usr" \
    --target=$cfg_target_canonical \
    --host=$cfg_target_canonical \
    --build=$cfg_host_canonical \
    --enable-shared \
    --enable-static
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
  for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libconfig*.so*; do
    if [ -L "$f" ]; then
      cp -av "$f" "$cfg_dir_rootfs/usr/lib"
    else
      $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
    fi
  done
}


