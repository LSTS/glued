version=\
(
    'v1.0.0'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4x64/gcc-5.4/rpi4cfs-1uart.tar.gz"
)

md5=\
(
    '07695298f8ff7a7c69f4944e9a0cd893'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
