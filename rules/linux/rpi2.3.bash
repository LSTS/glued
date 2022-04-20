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
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi2.3/gcc-5.4/linux-$version.tar.gz"
)

md5=\
(
    '4f54828e18641ad5e99a36019bdc103b'
)

requires=\
(
    'lz4/host-rpi2.3'
    'bc/host-rpi2.3'
    'kmod/host-rpi2.3'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
