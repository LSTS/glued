version=\
(
    'v1.0.3'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a6xx/gcc-5.4/pps-tools-$version.tar.gz"
)

md5=\
(
    'ec679956580f25c9bdef70e41067bcb2'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
