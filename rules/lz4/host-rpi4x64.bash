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
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4x64/gcc-5.4/lz4-${version}-host.tar.gz"
)

md5=\
(
    '7a3387d58eb463f310ce5297fd8e51fe'
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
