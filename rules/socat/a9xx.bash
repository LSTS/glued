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
    "https://www.lsts.pt/glued/cloud/package/lctr-a9xx/gcc-5.4/a9xx-socat-$version.tar.gz"
)

md5=\
(
    '2fecca425991b4df27f7cf387074b230'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
