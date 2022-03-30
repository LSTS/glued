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
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/sshpass-${version}.tar.gz"
)

md5=\
(
    "1f1413c4bf079b4facca8fb1f436db34"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
