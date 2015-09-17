version=\
(
    "2.7"
)

url=\
(
    "http://www.digip.org/jansson/releases/jansson-2.7.tar.gz"
)

md5=\
(
    "3a106a465bbb77637550b422f5b262ef"
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
  # Libs:
  for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libjansson.*; do
    if [ -L "$f" ]; then
      $cmd_cp "$f" "$cfg_dir_rootfs/usr/lib"
    else
      $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
    fi
  done
}
