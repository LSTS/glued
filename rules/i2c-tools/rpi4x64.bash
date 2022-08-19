version=\
(
    'v3.1.0'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4x64/gcc-5.4/rpi4x64-i2c-tools-$version.tar.gz"
)

md5=\
(
    '732ee4a3d4281d1d66addd3ea71ec1db'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
