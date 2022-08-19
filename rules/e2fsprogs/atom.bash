version=\
(
    'v1.42.13'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-atom/gcc-5.4/atom-e2fsprogs-$version.tar.gz"
)

md5=\
(
    'de2ebe1b0bb8c484e799ca82d3dc3a89'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
