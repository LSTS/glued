version=\
(
    'v1.2.6'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4x64/gcc-5.4/rpcbind-$version.tar.gz"
)

md5=\
(
    '369ca9239d572e1ade47d1de8ee84d06'
)

requires=\
(
    'libtirpc/rpi4x64'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
