version=\
(
    "v1.05"
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a6xx/gcc-5.4/sshpass-${version}.tar.gz"
)

md5=\
(
    "c375976825faf205487fccdcb6ce9d16"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
