version=\
(
    'v2015.67'
)

requires=\
(
    'zlib/atom'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-atom/gcc-5.4/dropbear-$version.tar.gz"
)

md5=\
(
    '1ac9c5d03288decbd216925ac43a5fe0'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
