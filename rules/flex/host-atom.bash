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
    "https://www.lsts.pt/glued/cloud/package/lctr-atom/gcc-5.4/flex-$version-host.tar.gz"
)

md5=\
(
    '0895c922567aa164df4e1bbcdfe45fa3'
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
