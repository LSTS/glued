version=\
(
    "v1.6.1"
)

requires=\
(
    'flex/host-a9xx'
    'bison/host-a9xx'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a9xx/gcc-5.4/libpcap-${version}.tar.gz"
)

md5=\
(
    "809a2f5e99ffbf86c833fdb68e91bc05"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
