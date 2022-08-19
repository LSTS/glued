version=\
(
    'v7.10.1'
)

requires=\
(
    'readline/rpi4'
    'ncurses/rpi4'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/gcc-5.4/rpi4-gdb-${version}.tar.gz"
)

md5=\
(
    "8e11c002036f347b874d63ac37235dd8"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
