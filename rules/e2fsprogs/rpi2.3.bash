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
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi2.3/gcc-5.4/e2fsprogs-$version.tar.gz"
)

md5=\
(
    'c085ca6e5f6cf21271613a442d8d82d7'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
