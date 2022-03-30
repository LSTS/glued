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
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/gcc-5.4/rpcbind-$version.tar.gz"
)

md5=\
(
    '052fc0fe1b3afdda3997a0e1db940ce5'
)

requires=\
(
    'libtirpc/rpi4'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
