version=\
(
    "v2.07"
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-atom/gcc-5.4/nasm-$version-host.tar.gz"
)

md5=\
(
    'a4ba6a315f30c517fcd897001f388d24'
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
