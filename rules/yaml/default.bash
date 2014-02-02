version=\
(
  "0.1.4"
)

url=\
(
  "http://pyyaml.org/download/libyaml/yaml-${version}.tar.gz"
)

md5=\
(
  "36c852831d02cf90508c29852361d01b"
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
  for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libyaml*.so*; do
    if [ -L "$f" ]; then
      cp -av "$f" "$cfg_dir_rootfs/usr/lib"
    else
      $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
    fi
  done
}


