version=\
(
    "v2.8.9"
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/cmake-${version}-host.tar.gz"
)

md5=\
(
    "f300fe9a01ce135911fd049e2b75d135"
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
