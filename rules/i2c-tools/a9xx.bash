version=\
(
    'v3.1.0'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a9xx/gcc-5.4/a9xx-i2c-tools-$version.tar.gz"
)

md5=\
(
    '32b474a1ee7a315372ef5d499c0264d5'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
