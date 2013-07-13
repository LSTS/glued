source $PKG_COMMON

requires=\
(
    'protobuf/cross'
)

configure()
{
  ./configure \
    --prefix="${cfg_dir_toolchain_sysroot}/usr" \
    --build=$cfg_host_canonical \
    --host="$cfg_target_canonical" \
    --target="$cfg_target_canonical" \
    --with-protoc=$pkg_build_dir/../cross/glued_host/bin/protoc
}

comment=\
(
  "24/10/2012 - In test yet."
)

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
  for f in "$cfg_dir_toolchain_sysroot/usr/lib/"*proto*.so*; do
    if [ -L "$f" ]; then
      cp -av "$f" "$cfg_dir_rootfs/usr/lib"
    else
      $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
    fi
  done
}

