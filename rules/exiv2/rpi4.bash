version=\
(
  "v0.25"
)

requires=\
(
    "gettext/host-rpi4"
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/exiv2-${version}.tar.gz"
)

md5=\
(
    "02a2c3d0ab6ab55119be3c88fae38540"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}

