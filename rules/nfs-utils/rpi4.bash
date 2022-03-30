version=\
(
    'v1.3.2'
)

url=\
(
    "http://downloads.sourceforge.net/nfs/$version/nfs-utils-$version.tar.bz2"
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/gcc-5.4/nfs-utils-$version.tar.gz"
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
