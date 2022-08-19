version=\
(
    'v1.3.2'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a6xx/gcc-5.4/a6xx-nfs-utils-$version.tar.gz"
)

requires=\
(
    'libtirpc/a6xx'
)

md5=\
(
    '01ec249681d2cbb637b751d1732b2cb9'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
