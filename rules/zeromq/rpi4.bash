version=\
(
    "v4.1.3"
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/zeromq-${version}.tar.gz"
)

md5=\
(
    "b487c0bcc4d7f17cc6dcf24d8734b9b9"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
