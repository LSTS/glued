version=\
(
    'v4.9.99'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-atom/gcc-5.4/linux-$version.tar.gz"
)

md5=\
(
    '51f01d010dd7876e057a88596f0cc321'
)

requires=\
(
    'bc/host-atom'
    'kmod/host-atom'
    'lz4/host-atom'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
