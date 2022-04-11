version=\
(
    'v1.1.0'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a6xx/gcc-5.4/coreboot-lsts-${version}.tar.gz"
)

md5=\
(
    "e873084905829c191045b4f28c2a3ae6"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
