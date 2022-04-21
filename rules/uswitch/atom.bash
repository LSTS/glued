version=\
(
    'v1.0'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-atom/gcc-5.4/uswitch-$version.tar.gz"
)

md5=\
(
    '88db9a45f524008be0751c11fba85560'
)

requires=\
(
    'libusb/atom'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
