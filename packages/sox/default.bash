version=\
(
    "14.4.1"
)

url=\
(
    "http://downloads.sourceforge.net/project/sox/sox/14.4.1/sox-$version.tar.gz"
)

md5=\
(
    "670307f40763490a2bc0d1f322071e7a"
)

requires=( 
  "alsa-lib/default"
  "alsa-utils/default"
  "flac/default"
)

configure()
{
    ./configure \
        --prefix="${cfg_dir_toolchain_sysroot}/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical"
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
  $cmd_target_strip -v "$cfg_dir_toolchain_sysroot/usr/bin/"*-sox* -o "$cfg_dir_rootfs/usr/bin/sox"

  # Libs: 
  for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libsox*.so*; do
    if [ -L "$f" ]; then
      $cmd_cp "$f" "$cfg_dir_rootfs/usr/lib"
    else
      $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
    fi
  done
}
