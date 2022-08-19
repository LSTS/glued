version=\
(
    'v2.71'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/gcc-5.4/rpi4-autoconf-${version}-host.tar.gz"
)

md5=\
(
    "e460c4fe12089ee12ac33afc5f92cfe3"
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
