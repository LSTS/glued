version=\
(
    "v2.4.13"
)

requires=\
(
    'cmake/host-rpi4'
    'ffmpeg/rpi4'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/gcc-5.4/rpi4-opencv-${version}.tar.gz"
)

md5=\
(
    "0111d399fed9a1509be563cdab95d8a4"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
