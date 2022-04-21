version=\
(
    'v3.1.1'
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
    "https://www.lsts.pt/glued/cloud/package/lctr-atom/gcc-5.4/rsync-$version.tar.gz"
)

md5=\
(
    'de795d0e6a23a2d71a1a7d794b145725'
)


post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
