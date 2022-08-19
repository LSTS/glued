version=\
(
    'v2.4.9'
)

requires=\
(
    'libpcap/a9xx'
    'openssl/a9xx'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a9xx/gcc-5.4/a9xx-ppp-${version}.tar.gz"
)

md5=\
(
    "51e22f704ce5722f845a348d2da7f06c"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
