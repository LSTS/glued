version=\
(
    'v2.4.6'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/gcc-5.4/libtool-${version}-host.tar.gz"
)

md5=\
(
    '922293162e06b392472d2aff06502467'
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
