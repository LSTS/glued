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
    "https://www.lsts.pt/glued/cloud/package/lctr-a6xx/gcc-5.4/bash-${version}.tar.gz"
)

md5=\
(
    "5b141cefecb2e803aca6bf58211ef5ac"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
