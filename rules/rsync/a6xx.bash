version=\
(
    'v3.1.1'
)

requires=\
(
    'zlib/a6xx'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a6xx/gcc-5.4/a6xx-rsync-$version.tar.gz"
)

md5=\
(
    '3a5d471642370460b282b8b74bd602c3'
)


post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
