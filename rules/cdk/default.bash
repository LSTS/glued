version=\
(
  "5.0-20120323"
)

url=\
(
  "ftp://invisible-island.net/cdk/cdk.tar.gz"
)

md5=\
(
  "929969d06ce034e862976bb7d1a36b25"
)

requires=\
(
    'ncurses/default'
)

configure()
{
#        --target="${cfg_target_canonical}" \
  ./configure \
    --prefix="$cfg_dir_toolchain_sysroot/usr" \
    --host="${cfg_target_canonical}" \
    --build="${cfg_host_canonical}" \
        --target="${cfg_target_canonical}" \
    --with-ncursesw \
    --with-shared   \

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
  for f in "$cfg_dir_toolchain_sysroot/usr/lib/libcdk"* ; do
    if [ -L "$f" ]; then
      cp -av "$f" "$cfg_dir_rootfs/usr/lib"
    else
      $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
    fi
  done
}
