version=\
(
    "v5.31b"
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a6xx/gcc-5.4/memtest86+-$version.tar.gz"
)

md5=\
(
    '6ffd246eb9694313bf2c2712f35df195'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
