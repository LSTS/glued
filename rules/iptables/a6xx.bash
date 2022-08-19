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
    "https://www.lsts.pt/glued/cloud/package/lctr-a6xx/gcc-5.4/a6xx-iptables-${version}.tar.gz"
)

md5=\
(
    "5a53ee02c796156c5c5f3af0a41db8c9"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
