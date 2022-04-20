version=\
(
    'v1.2.7'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi2.3/gcc-5.4/zlib-$version.tar.gz"
)

md5=\
(
    '8ed7a1aff64d963f9d962cdf2f00107e'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
