version=\
(
    "v21"
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-atom/gcc-5.4/kmod-$version-host.tar.gz"
)

md5=\
(
    'c6e2def95e0878c27b4c57713db06e87'
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
