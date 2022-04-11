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
    "https://www.lsts.pt/glued/cloud/package/lctr-a6xx/gcc-5.4/nasm-$version-host.tar.gz"
)

md5=\
(
    '32ee681fbf165a596b0aac0619d0821d'
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
