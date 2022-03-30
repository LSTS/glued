version=\
(
    "v2.11.3.121"
)

requires=\
(
    'libusb/rpi4'
    'libraw1394/rpi4'
    'libdc1394/rpi4'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/gcc-5.4/pointgrey-${version}-armhf.tar.gz"
)

md5=\
(
    "4181d805fbff2985747d3064e08235ec"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
