version=\
(
    'v4.9.y'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi2.3/gcc-5.4/rpi-boot-firmware-$version.tar.gz"
)

md5=\
(
    '00a481329f58ac6cd1709499f35e2955'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
