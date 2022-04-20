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
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi2.3/gcc-5.4/ptpd-$version.tar.gz"
)

md5=\
(
    '521912e07db4fb8285c7a711dae786ef'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
