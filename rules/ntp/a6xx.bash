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
    "https://www.lsts.pt/glued/cloud/package/lctr-a6xx/gcc-5.4/ntp-$version.tar.gz"
)

md5=\
(
    '1882642e1c359210548af106b93a6a32'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
