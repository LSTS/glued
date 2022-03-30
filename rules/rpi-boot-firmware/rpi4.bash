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
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/gcc-5.4/rpi-boot-firmware-$version.tar.gz"
)

md5=\
(
    'f571ad57471f6c0e113d14a8d6037780'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
