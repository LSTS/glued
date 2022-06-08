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
    "https://www.lsts.pt/glued/cloud/package/lctr-a9xx/gcc-5.4/bison-${version}-host.tar.gz"
)

md5=\
(
    "d933ffff89c523ad81060eb170bb2a4a"
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
