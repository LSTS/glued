version=\
(
    "v1.55.0"
)

requires=\
(
    'bzip2/rpi4'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/boost-${version}.tar.gz"
)

md5=\
(
    "fd82afbae82d0f5899b4453b59c64769"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
