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
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4x64/gcc-5.4/rpi4cfs-5uart.tar.gz"
)

md5=\
(
    'fe9697525ddb5143a439aaaa01440a26'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
