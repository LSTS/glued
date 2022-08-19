version=\
(
    'v0.2.2'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a6xx/gcc-5.4/a6xx-rpcbind-$version.tar.gz"
)

md5=\
(
    '91bf7d06ff09d7ec3b3d7319db07a881'
)

requires=\
(
    'libtirpc/a6xx'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
