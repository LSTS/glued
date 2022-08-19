version=\
(
    'v3.1.0'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/gcc-5.4/rpi4-i2c-tools-$version.tar.gz"
)

md5=\
(
    '3af72c0b5f01f39fe63344a91670a7be'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
