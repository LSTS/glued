version=\
(
    'v3.1.1'
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
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi2.3/gcc-5.4/rsync-$version.tar.gz"
)

md5=\
(
    '319c005492bbee125b06400378e501f8'
)


post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
