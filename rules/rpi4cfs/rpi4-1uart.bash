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
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/gcc-5.4/rpi4cfs-1uart.tar.gz"
)

md5=\
(
    'cdb976d04306a8015ef4177a72c09a96'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
