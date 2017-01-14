version=\
(
  "20121125-2245-stable"
)

url=\
(
  "ftp://ftp.videolan.org/pub/videolan/x264/snapshots/x264-snapshot-$version.tar.bz2"
)

md5=\
(
  "285f6d498574a31857e06af75b6ea594"
)

configure()
{
  "../x264-snapshot-$version/configure"      \
    --sysroot="${cfg_dir_toolchain_sysroot}" \
    --cross-prefix="${cmd_target_prefix}"    \
    --host="$cfg_target_canonical"           \
    --prefix="${cfg_dir_toolchain_sysroot}/usr" \
    --disable-asm
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
  $cmd_cp "$cfg_dir_toolchain_sysroot/usr/bin/x264" "$cfg_dir_rootfs/usr/bin"
}

