version=\
(
    '2.0.1'
)

url=\
(
    "http://freefr.dl.sourceforge.net/project/expat/expat/$version/expat-$version.tar.gz"
)

md5=\
(
    'ee8b492592568805593f81f8cdf2a04c'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
    "../expat-$version/configure" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --disable-static \
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
  for f in "$cfg_dir_toolchain_sysroot/usr/lib/libexpat"*".so"*; do
    if [ -L "$f" ]; then
      $cmd_cp "$f" "$cfg_dir_rootfs/usr/lib"
    else
      $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
   fi
  done
}
