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
    "https://www.lsts.pt/glued/cloud/package/lctr-a9xx/gcc-5.4/ntp-$version.tar.gz"
)

md5=\
(
    '6512cb6ce8cb6590b93ed5aae15e57ae'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
