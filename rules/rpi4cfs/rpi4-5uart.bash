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
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/gcc-5.4/rpi4-rpi4cfs-5uart.tar.gz"
)

md5=\
(
    'fe9697525ddb5143a439aaaa01440a26'
)

target_install()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
