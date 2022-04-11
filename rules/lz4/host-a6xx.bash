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
    "https://www.lsts.pt/glued/cloud/package/lctr-a6xx/gcc-5.4/lz4-$version-host.tar.gz"
)

md5=\
(
    '78ee92e22d5aaa69ba1866a20decf5fe'
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
