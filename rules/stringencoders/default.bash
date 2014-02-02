version=\
(
    "v3.10.3"
)

url=\
(
    "http://stringencoders.googlecode.com/files/stringencoders-${version}.tar.gz"
)

md5=\
(
    "5862082d1ffd2708a9689e676978e005"
)

requires=\
(
    'qemu/host'
)

configure()
{
  export CFLAGS="-O3 -Wall"

  ./configure \
    --prefix="${cfg_dir_toolchain_sysroot}/usr" \
    --target=$cfg_target_canonical \
    --host=$cfg_target_canonical \
    --build=$cfg_host_canonical

  sed -i "s#\t./modp#\tqemu-arm -L ${cfg_dir_rootfs} ${cfg_dir_rootfs}/lib/ld-linux.so.3\t./modp#g" Makefile
  sed -i "s#DEFAULT_INCLUDES =#DEFAULT_INCLUDES = -I src #g" Makefile
}

build()
{
  $cmd_make CFLAGS="-O3 -Wall" -I="src"
}

host_install()
{
  $cmd_make install
}

target_install()
{
  for f in "${cfg_dir_toolchain_sysroot}/usr/lib/"libmodpbase*so*; do
    echo "Strpping and copying $f in in rootfs/lib "
    $cmd_target_strip "$f" -o "${cfg_dir_rootfs}/lib/$(basename "$f")"
  done
}

