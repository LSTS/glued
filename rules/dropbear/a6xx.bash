version=\
(
    'v2015.67'
)

requires=\
(
    'zlib/a6xx'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a6xx/gcc-5.4/dropbear-$version.tar.gz"
)

md5=\
(
    'faf99f41f526e260fb508a0f504b477b'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
