version=\
(
    'v2015.67'
)

requires=\
(
    'zlib/rpi4x64'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4x64/gcc-5.4/rpi4x64-dropbear-$version.tar.gz"
)

md5=\
(
    '35302e38fccb85a9211ebc93c22bfcaa'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
