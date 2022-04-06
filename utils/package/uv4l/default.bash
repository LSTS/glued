version=\
(
  "1.0.0"
)

url=\
(
  "http://lsts.pt/glued/uv4l.$version.tar.bz2"
)

md5=\
(
  "869e884accbfa9c2356e2fd9307dd71c"
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

post_unpack()
{
    mv "../etc" "../uv4l-$version/"
    mv "../usr" "../uv4l-$version/"
}

host_install()
{
  $cmd_cp -r "usr/lib/"*    "$cfg_dir_toolchain_sysroot/usr/lib/"
  $cmd_cp -r "usr/include/"* "$cfg_dir_toolchain_sysroot/usr/include/"
}

target_install()
{
    $cmd_cp -r "usr/lib/"* "$cfg_dir_rootfs/usr/lib/"
    $cmd_cp -r "usr/bin/"* "$cfg_dir_rootfs/usr/bin/"

    tar -C "$pkg_dir/fs" -c -f - . | tar -C "$cfg_dir_rootfs" -x -v -f -
}


