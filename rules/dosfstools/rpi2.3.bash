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
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi2.3/gcc-5.4/dosfstools-$version.tar.gz"
)

md5=\
(
    '5f8492b90a6fe905b998c6498d92375c'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
