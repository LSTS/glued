version=\
(
    'v2015.67'
)

requires=\
(
    'zlib/rpi2.3'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi2.3/gcc-5.4/dropbear-$version.tar.gz"
)

md5=\
(
    'bd3a82efc422501b3c9fe2da5e8e2123'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
