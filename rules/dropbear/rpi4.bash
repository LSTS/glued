version=\
(
    '2015.67'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/gcc-5.4/dropbear-$version.tar.gz"
)

md5=\
(
    '0ce600f1f8a68184c6dff2d89509433d'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
