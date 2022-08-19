version=\
(
    'v8.0'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4x64/gcc-5.4/rpi4x64-readline-${version}.tar.gz"
)

md5=\
(
    "bb4e8ea6bd6f6bbcb72faa5ef029f485"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
