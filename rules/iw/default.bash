version=\
(
    "4.9"
)

url=\
(
    "http://lsts.pt/glued/iw-$version.tar.bz2"
)

md5=\
(
  "ae8ccaa154449300c2c02eb90a37eebb"
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

configure()
{
    mv "../iw_$version/etc" "../iw-$version/"
    mv "../iw_$version/lib" "../iw-$version/"
    mv "../iw_$version/sbin" "../iw-$version/"
}

target_install()
{
    $cmd_cp -r "etc/"* "$cfg_dir_rootfs/etc/"
    $cmd_cp -r "sbin/"* "$cfg_dir_rootfs/sbin/"
    $cmd_cp -r "lib/"* "$cfg_dir_rootfs/lib/"
    $cmd_cp -r "$pkg_dir/fs/"* "$cfg_dir_rootfs/"
}
