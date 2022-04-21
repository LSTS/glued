version=\
(
    'v1.0.71'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-atom/gcc-5.4/escc-$version.tar.gz"
)

md5=\
(
    '1ac00d7490f36ca6b6d17cba7aaa29d3'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
