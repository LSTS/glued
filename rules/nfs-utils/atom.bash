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
    "https://www.lsts.pt/glued/cloud/package/lctr-atom/gcc-5.4/nfs-utils-$version.tar.gz"
)

requires=\
(
    'libtirpc/atom'
)

md5=\
(
    '16cd65d77e4649fa5170c1824d323f43'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
