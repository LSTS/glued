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
    "https://www.lsts.pt/glued/cloud/package/lctr-atom/gcc-5.4/atom-linux-$version.tar.gz"
)

md5=\
(
    '63b390740846af07ef05292c03fd7018'
)

requires=\
(
    'bc/host-atom'
    'kmod/host-atom'
    'lz4/host-atom'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
