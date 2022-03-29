version=\
(
    'v0.18.3.1'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/gettext-${version}.tar.gz"
)

md5=\
(
    "5e675315943df5f5e49204d294c17e10"
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
