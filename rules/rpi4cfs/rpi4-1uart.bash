version=\
(
    'v1.0.0'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/gcc-5.4/rpi4cfs-default-$version.tar.gz"
)

md5=\
(
    '18049b8a3f7793ca2de8286f2700b4b5'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
