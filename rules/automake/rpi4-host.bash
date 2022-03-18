version=\
(
    'v1.16'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/automake-${version}.tar.gz"
)

md5=\
(
    "465c4cfa1e613175fd04db244f130077"
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
