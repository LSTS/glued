version=\
(
    'v1.0.71'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a6xx/gcc-5.4/escc-$version.tar.gz"
)

md5=\
(
    'dfe89f9345ed03bb01d8670e5a5e0795'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
