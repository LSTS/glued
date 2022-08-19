version=\
(
    'v112'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-atom/gcc-5.4/atom-lz4-$version-host.tar.gz"
)

md5=\
(
    'a66b7a63e18486c7044ebb2bb3af9fd4'
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
