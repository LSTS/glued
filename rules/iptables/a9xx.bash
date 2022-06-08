version=\
(
    "v1.4.14"
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a9xx/gcc-5.4/iptables-${version}.tar.gz"
)

md5=\
(
    "bd0d449b383dadc1899d6c07d27ed481"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
