version=\
(
    "v3.1.8"
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-atom/gcc-5.4/atom-pciutils-${version}.tar.gz"
)

md5=\
(
    "4e97c6fba96e2f7ef89beb75f38ed5a7"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
