version=\
(
    'v4.19_2020-07-16'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/gcc-5.4/rpi4-rpi-linux-$version.tar.gz"
)

md5=\
(
    'fcb811bbce80562076598cc7cd5db1be'
)

requires=\
(
    'lz4/host-rpi4'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
