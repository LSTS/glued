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
    "https://www.lsts.pt/glued/cloud/base/lctr-a6xx/glued-base-gcc5.4-lctr-a6xx.tar.gz"
)

md5=\
(
    'dea7ff4990bd7c9deab08c053bb54d95'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
