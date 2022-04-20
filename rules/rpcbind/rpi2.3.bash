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
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi2.3/gcc-5.4/rpcbind-$version.tar.gz"
)

md5=\
(
    'a2e994495c8e426c06b0bf4156ede63a'
)

requires=\
(
    'libtirpc/rpi2.3'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
