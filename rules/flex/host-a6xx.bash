version=\
(
    "v2.5.35"
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a6xx/gcc-5.4/flex-$version-host.tar.gz"
)

md5=\
(
    '1dfd7d5bb6ae3d29f990863a3123641c'
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
