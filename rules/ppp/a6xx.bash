version=\
(
    'v2.4.5'
)

requires=\
(
    'libpcap/a6xx'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a6xx/gcc-5.4/a6xx-ppp-${version}.tar.gz"
)

md5=\
(
    "6f2070699235827b611b232cde3890e7"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
