version=\
(
    "v3.0.2"
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/gcc-5.4/czmq-${version}.tar.gz"
)

requires=\
(
    'libtool/rpi4-host'
    'zeromq/rpi4'
)

md5=\
(
    "920700dea07d2fdd21d4061c63a3c071"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
