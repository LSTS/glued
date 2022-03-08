version=\
(
  "1.1"
)

url=\
(
  "http://freefr.dl.sourceforge.net/project/log4cpp/log4cpp-${version}.x%20%28new%29/log4cpp-${version}/log4cpp-${version}.tar.gz"
)

md5=\
(
  "b9ef6244baa5e5e435f35e0b9474b35d"
)

configure()
{
  cd ../log4cpp
  ./configure \
    --prefix="${cfg_dir_toolchain_sysroot}/usr" \
    --target=$cfg_target_canonical \
    --host=$cfg_target_canonical \
    --build=$cfg_host_canonical
}

build()
{
  cd ../log4cpp
  $cmd_make 
}

host_install()
{
  cd ../log4cpp
  $cmd_make install
}

target_install()
{
  # Libs: 
  for f in "$cfg_dir_toolchain_sysroot/usr/lib/"liblog4cpp*; do
    if [ -L "$f" ]; then
      $cmd_cp "$f" "$cfg_dir_rootfs/usr/lib"
    else
      $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
    fi
  done
}

