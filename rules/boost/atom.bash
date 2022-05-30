version=\
(
    "v1.55.0"
)

requires=\
(
    'bzip2/atom'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-atom/gcc-5.4/boost-${version}.tar.gz"
)

md5=\
(
    "11cf8f41c7b481a67ae0debd8680db13"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
