version=\
(
    'v1.0.0'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

requires=\
(
    'bash/rpi4'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/gcc-5.4/glued-apk-${version}.tar.gz"
)

md5=\
(
    "23a205a8bc88a0556c59492024705cb6"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}

