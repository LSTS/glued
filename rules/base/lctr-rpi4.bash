version=\
(
    '2.0'
)

maintainer=\
(
    'Pedro Gonçalves <rpedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/base/lctr-rpi4/glued-base-gcc5.4-lctr-rpi4.tar.gz"
)

md5=\
(
    '3dcf0e1565054dca9cc61722cefac2d4'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
