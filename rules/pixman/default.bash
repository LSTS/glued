version=\
(
    "0.30.0"
)

url=\
(
    "http://cairographics.org/releases/pixman-$version.tar.gz"
)

md5=\
(
    "ae7ac97921dfa59086ca2231621a79c7"
)

configure()
{
    ./configure \
        --prefix="${cfg_dir_toolchain_sysroot}/usr" \
        --target="$cfg_target_canonical"            \
        --host="$cfg_target_canonical"              \
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
  for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libpixman*.so*; do
    if [ -L "$f" ]; then
      $cmd_cp "$f" "$cfg_dir_rootfs/usr/lib"
    else
      $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
    fi
  done
}


