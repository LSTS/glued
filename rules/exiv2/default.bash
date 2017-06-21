version=\
(
  "0.25"
)

url=\
(
  "http://lsts.pt/glued/exiv2-${version}.tar.gz"
)

md5=\
(
  "258d4831b30f75a01e0234065c6c2806"
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

configure()
{
  ./configure \
    --datadir="$cfg_dir_toolchain_sysroot" \
    --prefix="$cfg_dir_rootfs/usr" \
    --includedir="$cfg_dir_toolchain_sysroot/usr/include" \
    --enable-cross-compile \
    --build=$cfg_target_linux \
    --host="$cfg_target_canonical" \
    --enable-shared \
    --disable-static \
    --disable-xmp
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
  for f in "$cfg_dir_rootfs/lib/"libexiv2*; do
      cp -av "$f" "$cfg_dir_toolchain_sysroot/usr/lib"
  done
}

