version=\
(
    'v3.1.1'
)

requires=\
(
    'zlib/rpi4x64'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4x64/gcc-5.4/rsync-$version.tar.gz"
)

md5=\
(
    'f71349a7dd1bc0ebc65569630867a234'
)


post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
