version=\
(
    "v4.4.18"
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/gcc-5.4/bash-${version}.tar.gz"
)

md5=\
(
    "1c2a8aade42320147c59faa228ae134f"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
