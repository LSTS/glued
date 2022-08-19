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
    "https://www.lsts.pt/glued/cloud/package/lctr-atom/gcc-5.4/atom-rpcbind-$version.tar.gz"
)

md5=\
(
    '3a077befe2bf9a65ebcc0d0465c65b20'
)

requires=\
(
    'libtirpc/atom'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
