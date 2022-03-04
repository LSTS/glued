version=\
(
    'v1.2.7'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/zlib-$version.tar.gz"
)

md5=\
(
    '24d09f1eec51ad86bff4cbb29a4a1ff6'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
