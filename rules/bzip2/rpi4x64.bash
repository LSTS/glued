version=\
(
    "v1.0.6"
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4x64/gcc-5.4/rpi4x64-bzip2-${version}.tar.gz"
)

md5=\
(
    "9b845e3a36d9f1f279b51c44c0a9f4b5"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
