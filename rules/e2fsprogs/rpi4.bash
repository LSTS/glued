version=\
(
    'v1.42.13'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/gcc-5.4/e2fsprogs-$version.tar.gz"
)

md5=\
(
    'f28d5749c553761d26ef0f12e3e2f05c'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
