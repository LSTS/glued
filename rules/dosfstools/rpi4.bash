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
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/gcc-5.4/dosfstools-$version.tar.gz"
)

md5=\
(
    '4fc03b732f5aff05a5040660a479853b'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
