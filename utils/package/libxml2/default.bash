version=\
(
    "2.7.8"
)

url=\
(
    "ftp://xmlsoft.org/libxml2/libxml2-$version.tar.gz"
)

md5=\
(
    "8127a65e8c3b08856093099b52599c86"
)

configure()
{
    ../libxml2-$version/configure \
        --prefix="${cfg_dir_toolchain_sysroot}/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --with-gnu-ld \
        --without-debug \
        --without-python
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
    sed -i "s,^prefix=.*,prefix=\'${cfg_dir_toolchain_sysroot}/usr\',g" ${cfg_dir_toolchain_sysroot}/usr/bin/xml2-config
    sed -i "s,^exec_prefix=.*,exec_prefix=\'${cfg_dir_toolchain_sysroot}/usr\',g" ${cfg_dir_toolchain_sysroot}/usr/bin/xml2-config
}

target_install()
{
  # Libs: 
  for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libxml2*.so*; do
    if [ -L "$f" ]; then
      $cmd_cp "$f" "$cfg_dir_rootfs/usr/lib"
    else
      $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
    fi
  done
}


