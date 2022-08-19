version=\
(
    'v2.4.6'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/gcc-5.4/rpi4-libtool-${version}-host.tar.gz"
)

md5=\
(
    '16bdd301aed6f1a648ebc502048c8288'
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
