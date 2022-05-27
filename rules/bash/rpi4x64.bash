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
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4x64/gcc-5.4/bash-${version}.tar.gz"
)

md5=\
(
    "6687cd1f659edf502da49dbd83afbcd9"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
