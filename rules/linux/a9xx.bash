version=\
(
    'v3.14.63'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a9xx/gcc-5.4/a9xx-linux-$version.tar.gz"
)

md5=\
(
    '32d9d9d99f233c02e38573e17d691dc1'
)

requires=\
(
    'bc/host-a9xx'
    'kmod/host-a9xx'
    'lz4/host-a9xx'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
