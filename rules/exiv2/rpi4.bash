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
    "2f502ab8fb798f7dc69b75bb25972670"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}

