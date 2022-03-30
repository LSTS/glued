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
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/gcc-5.4/lz4-${version}-host.tar.gz"
)

md5=\
(
    'b70422c37ff881a3787c9456bc9c89a8'
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
