version=\
(
    'v3.1.1'
)

requires=\
(
    'zlib/a9xx'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a9xx/gcc-5.4/a9xx-rsync-$version.tar.gz"
)

md5=\
(
    'a22cf69fb24348e66321fa7e75cf37f9'
)


post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
