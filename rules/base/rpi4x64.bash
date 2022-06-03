version=\
(
    '2.0'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/base/lctr-rpi4x64/glued-base-gcc5.4-lctr-rpi4x64.tar.gz"
)

md5=\
(
    '48c1abcbffdf50098034bb1df0d320af'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
