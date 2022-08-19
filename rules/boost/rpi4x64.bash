version=\
(
    "v1.75.0"
)

requires=\
(
    'bzip2/rpi4x64'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4x64/gcc-5.4/rpi4x64-boost-${version}.tar.gz"
)

md5=\
(
    "5e23625b997eb2570c432c82e36d70e8"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
