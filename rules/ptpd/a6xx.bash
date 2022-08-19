version=\
(
    'v2.2.0'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a6xx/gcc-5.4/a6xx-ptpd-$version.tar.gz"
)

md5=\
(
    '6fbde21b4a4620a4865733de7d2e0eb3'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
