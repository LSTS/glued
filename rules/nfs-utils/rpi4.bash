version=\
(
    'v1.3.2'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/gcc-5.4/rpi4-nfs-utils-$version.tar.gz"
)

requires=\
(
    'libtirpc/rpi4'
)

md5=\
(
    'e38ecfa598d2f619027b6b329f72708c'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
