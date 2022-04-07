version=\
(
    '2.0'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/base/lctr-rpi4/glued-base-gcc5.4-lctr-rpi4.tar.gz"
)

md5=\
(
    '142881ba5a5d5cb1c4b8cfaf48a8f029'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
