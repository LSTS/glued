version=\
(
    'v5.15.y'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4x64/gcc-5.4/linux-$version.tar.gz"
)

md5=\
(
    '821189c3b0d7ab116cf73be5bbb4b253'
)

requires=\
(
    'lz4/host-rpi4x64'
    'flex/host-rpi4x64'
    'bison/host-rpi4x64'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
