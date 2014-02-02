version=\
(
    '1.4.6'
)

url=\
(
    "http://mirror.nohup.it/apache/apr/apr-$version.tar.bz2"
)

md5=\
(
    'ffee70a111fd07372982b0550bbb14b7'
)

# @todo patch.


configure()
{
  cd apr-${version}
  ./configure \
            --prefix="${cfg_dir_toolchain_sysroot}/usr" \
            --target="$cfg_target_canonical" \
            --host="$cfg_target_canonical" \
            --build="$cfg_host_canonical" \
            --enable-shared \
            --disable-static \
            ac_cv_file__dev_zero=yes \
            ac_cv_func_setpgrp_void=yes \
            apr_cv_tcp_nodelay_with_cork=no \
            apr_cv_process_shared_works=no \
            apr_cv_mutex_robust_shared=no \
            ac_cv_sizeof_struct_iovec=8 \
            apr_cv_mutex_recursive=yes
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
  # Libs: @todo
  for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libapr-*.so*; do
    if [ -L "$f" ]; then
      $cmd_cp "$f" "$cfg_dir_rootfs/usr/lib"
    else
      $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
    fi
  done
}
