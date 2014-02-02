version=\
(
    '1.3.1'
)

url=\
(
  "ftp://ftp.gnu.org/gnu/termcap/termcap-$version.tar.gz"
)

md5=\
(
  'ffe6f86e63a3a29fa53ac645faaabdfa'
)

configure()
{
  ./configure \
    --prefix="$cfg_dir_toolchain_sysroot/usr" \
    --target="$cfg_target_canonical" \
    --host="$cfg_target_canonical" \
    --build="$cfg_host_canonical" \
    --enable-shared
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
  for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libtermcap*; do
    if [ -L "$f" ]; then
      $cmd_cp "$f" "$cfg_dir_rootfs/usr/lib"
    else
      $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
    fi
  done

  # Terminfo:
  $cmd_cp "$cfg_dir_toolchain_sysroot/usr/share/terminfo" "$cfg_dir_rootfs/usr/share/"
}
