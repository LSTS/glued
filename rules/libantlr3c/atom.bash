version=\
(
    "v3.1.3"
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-atom/gcc-5.4/libantlr3c-${version}.tar.gz"
)

md5=\
(
    "3ed9bbe941460e3c1b1520ff031d0013"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
