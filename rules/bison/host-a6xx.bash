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
    "https://www.lsts.pt/glued/cloud/package/lctr-a6xx/gcc-5.4/bison-${version}-host.tar.gz"
)

md5=\
(
    "35071a32ae71365cf2bad15756915bdf"
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
