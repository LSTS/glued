version=\
(
  "0.43"
)

url=\
(
  "https://github.com/hanslub42/rlwrap/releases/download/v$version/rlwrap-$version.tar.gz"
)

md5=\
(
  "b993e83d3a292464de70719b32f83a34"
)

requires=(
  "readline/default"
)

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
  $cmd_cp  $cfg_dir_toolchain_sysroot/usr/share/rlwrap $cfg_dir_rootfs/usr/share/
  $cmd_cp  $cfg_dir_toolchain_sysroot/usr/bin/rlwrap $cfg_dir_rootfs/usr/bin/
}

