version=\
(
  "10.96"
)

url=\
(
  "https://lsts.pt/glued/exiftoolBin-${version}.tar.gz"
)

md5=\
(
  "71d52bf2d75f023b844dd8c9100daaff"
)

maintainer=\
(
  'Pedro Gonçalves <pedro@lsts.pt>'
)

requires=\
(
    'perl/default'
)

post_unpack()
{
    $cmd_cp -r ../exiftoolBin-${version}/* .
}

target_install()
{
   $cmd_cp -rv usr/* $cfg_dir_toolchain_sysroot/usr/
   $cmd_cp -rv usr/* $cfg_dir_rootfs/usr/
   $cmd_cp -rv usr/local/bin* $cfg_dir_rootfs/usr/bin/
}

