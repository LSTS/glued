version=\
(
    "v10.1"
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a9xx/gcc-5.4/libav-${version}.tar.gz"
)

md5=\
(
    "c11b022e7de77ec8d669a9214fd1c9d7"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
