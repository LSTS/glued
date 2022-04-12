version=\
(
    "v1.6.1"
)

requires=\
(
    'flex/host-a6xx'
    'bison/host-a6xx'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a6xx/gcc-5.4/libpcap-${version}.tar.gz"
)

md5=\
(
    "29a4bf4784c4a2d7c59f590257c5351f"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
