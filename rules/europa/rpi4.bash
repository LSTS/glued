version=\
(
    'v2.6-6693'
)

requires=\
(
    'ftjam/rpi4-host'
    'apache-ant/rpi4-host'
    'libantlr3c/rpi4'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/gcc-5.4/europa-${version}.tar.gz"
)

md5=\
(
    "25a209d03a788583ed8a59b31b04ba95"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
