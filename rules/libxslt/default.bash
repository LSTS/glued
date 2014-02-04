version=\
(
    "1.1.26"
)

url=\
(
    "ftp://xmlsoft.org/libxslt/libxslt-$version.tar.gz"
)

md5=\
(
    e61d0364a30146aaa3001296f853b2b9
)

post_unpack()
{
    patch -p1 < "$pkg_dir"/patches/libxslt-configure.patch
}

requires=\
(
    'libxml2/default'
    'libgcrypt/default'
)

configure()
{
    ./configure \
        LIBGCRYPT_CONFIG="$cfg_dir_toolchain_sysroot/usr/bin/libgcrypt-config" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
	--with-gnu-ld \
        --without-debug \
	--without-python --with-libxml-prefix=${cfg_dir_toolchain_sysroot}/usr/
}

build()
{
    $cmd_make 
}

host_install()
{
    $cmd_make install
    sed -i"s,^prefix=.*,prefix=\'${cfg_dir_toolchain_sysroot}/usr\',g" ${cfg_dir_toolchain_sysroot}/usr/bin/xslt-config
    sed -i "s,^exec_prefix=.*,exec_prefix=\'${cfg_dir_toolchain_sysroot}/usr\',g" ${cfg_dir_toolchain_sysroot}/usr/bin/xslt-config
    sed -i "s,^includedir=.*,includedir=\'${cfg_dir_toolchain_sysroot}/usr/include\',g" ${cfg_dir_toolchain_sysroot}/usr/bin/xslt-config
}

target_install()
{
  # Libs: libxslt
  for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libxslt*.so*; do
    if [ -L "$f" ]; then
      cp -av "$f" "$cfg_dir_rootfs/usr/lib"
    else
      $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
    fi
  done

  # Libs: libexslt
  for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libexslt*.so*; do
    if [ -L "$f" ]; then
      cp -av "$f" "$cfg_dir_rootfs/usr/lib"
    else
      $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
    fi
  done
}
