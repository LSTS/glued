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
    "https://www.lsts.pt/glued/cloud/package/lctr-atom/gcc-5.4/bash-${version}.tar.gz"
)

md5=\
(
    "8a55c9bbef3ef354ae87c0094da435d2"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
