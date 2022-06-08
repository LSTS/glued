version=\
(
    'v2.63'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a9xx/gcc-5.4/dnsmasq-$version.tar.gz"
)

md5=\
(
    'fd1cefd791a3788b5842fc11eb2fb705'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
