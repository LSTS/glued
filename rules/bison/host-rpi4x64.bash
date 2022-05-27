version=\
(
    'v2.5.1'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4x64/gcc-5.4/bison-${version}-host.tar.gz"
)

md5=\
(
    "815a2cebcabce93b0e40be257514bbea"
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
