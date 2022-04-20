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
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi2.3/gcc-5.4/lz4-${version}-host.tar.gz"
)

md5=\
(
    'ea1b97d08a3eafe44d0eb8f545feeb34'
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
