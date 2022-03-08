version=\
(
  "1.4.7"
)

url=\
(
  "http://oss.oetiker.ch/rrdtool/pub/rrdtool-$version.tar.gz"
)

md5=\
(
  "ffe369d8921b4dfdeaaf43812100c38f"
)

requires=\
(
  "libxml2/default"
  "libpng/default"
  "glib/default"
)

configure()
{
  ./configure                                   \
    --prefix="${cfg_dir_toolchain_sysroot}/usr" \
    --build="$cfg_host_canonical"               \
    --host="$cfg_target_canonical"              \
    --target="$cfg_target_canonical"            \
    --disable-ruby                              \
    --disable-tcl                               \
    --disable-python                            \
    --disable-rrd_graph                         \
    --disable-rrdcgi                            \
    --disable-perl                              \
    rd_cv_ieee_works=yes
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
  for f in "$cfg_dir_toolchain_sysroot/usr/lib/"librrd*.so*; do
    if [ -L "$f" ]; then
      $cmd_cp "$f" "$cfg_dir_rootfs/usr/lib"
    else
      $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
    fi
  done

  # Bin: 
  for f in "$cfg_dir_toolchain_sysroot/usr/bin/"*-rrd*; do
    if [ -L "$f" ]; then
      $cmd_cp "$f" "$cfg_dir_rootfs/usr/bin"
    else
      $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/bin/$(basename "$f")"
    fi
  done
}

