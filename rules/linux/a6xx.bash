version=\
(
    'v4.9.99'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a6xx/gcc-5.4/a6xx-linux-$version.tar.gz"
)

md5=\
(
    '6b64c76047e3674b18e0638892ffc563'
)

requires=\
(
    'bc/host-a6xx'
    'kmod/host-a6xx'
    'lz4/host-a6xx'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
