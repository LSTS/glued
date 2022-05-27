version=\
(
    'v3.0.28'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4x64/gcc-5.4/dosfstools-$version.tar.gz"
)

md5=\
(
    '83b5b97e7ba681fc0f00cb07d264c8a4'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
