version=\
(
    "1.2.1"
)

url=\
(
    "http://downloads.sourceforge.net/project/flac/flac-src/flac-${version}-src/flac-${version}.tar.gz"
)

md5=\
(
    "153c8b15a54da428d1f0fadc756c22c7"
)

requires=(
  "libogg/default"
)

post_unpack()
{
    patches=$(ls "$pkg_dir/patches-$version/"*.patch)
    if [ -n "$patches" ]; then
        cat $patches | patch -p1
    fi
}

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
  for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libFLAC*.so*; do
    if [ -L "$f" ]; then
      $cmd_cp "$f" "$cfg_dir_rootfs/usr/lib"
    else
      $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
    fi
  done
}

