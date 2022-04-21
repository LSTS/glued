version=\
(
    'v2.2.0'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-atom/gcc-5.4/ptpd-$version.tar.gz"
)

md5=\
(
    'a726a17009045fd32e2f966b8bf5fd2e'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
