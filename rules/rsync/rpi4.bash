version=\
(
    'v3.1.1'
)

requires=\
(
    'zlib/rpi4'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/gcc-5.4/rsync-$version.tar.gz"
)

md5=\
(
    '3f4faee463881746726ace558916dccb'
)


post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
