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
    "https://www.lsts.pt/glued/cloud/package/lctr-a9xx/gcc-5.4/uswitch-$version.tar.gz"
)

md5=\
(
    '960e41a21d1d81ee734e7cceb38ef83f'
)

requires=\
(
    'libusb/a9xx'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
