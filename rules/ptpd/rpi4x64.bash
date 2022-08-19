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
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4x64/gcc-5.4/rpi4x64-ptpd-$version.tar.gz"
)

md5=\
(
    '72fabcc9941fc35468f763af097974bd'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
