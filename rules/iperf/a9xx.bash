version=\
(
    'v2.0.4'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a9xx/gcc-5.4/iperf-$version.tar.gz"
)

md5=\
(
    '1250408f296865fc90524304867c010e'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
