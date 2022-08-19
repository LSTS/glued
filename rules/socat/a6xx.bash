version=\
(
    "v1.7.3.0"
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a6xx/gcc-5.4/a6xx-socat-$version.tar.gz"
)

md5=\
(
    'a3c6bd4cde068613b8ac6fac7a93262d'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
