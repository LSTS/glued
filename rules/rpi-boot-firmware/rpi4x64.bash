version=\
(
    'v2020-12-01'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4x64/gcc-5.4/rpi4x64-rpi-boot-firmware-$version.tar.gz"
)

md5=\
(
    '1330f592c4befec1ef675ebfac37056c'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
