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
    "https://www.lsts.pt/glued/cloud/base/lctr-atom/glued-base-gcc5.4-lctr-atom.tar.gz"
)

md5=\
(
    '44a665fd77bfbde0e7450733a69aafa9'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
