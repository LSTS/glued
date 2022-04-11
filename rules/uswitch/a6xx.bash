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
    "https://www.lsts.pt/glued/cloud/package/lctr-a6xx/gcc-5.4/uswitch-$version.tar.gz"
)

md5=\
(
    '0d3629ec4e09b6419fba286afa173039'
)

requires=\
(
    'libusb/a6xx'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
