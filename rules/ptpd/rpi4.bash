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
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/gcc-5.4/ptpd-$version.tar.gz"
)

md5=\
(
    'de9f47da1eaf63555e962eeb7e2aa2f2'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
