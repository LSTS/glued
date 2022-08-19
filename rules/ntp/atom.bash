version=\
(
    'v4.2.6p5'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-atom/gcc-5.4/atom-ntp-$version.tar.gz"
)

md5=\
(
    '634d46bad75a4c6eb01b3bedc159e738'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
