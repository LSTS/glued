version=\
(
    'v1.06'
)

requires=\
(
    'flex/host-a9xx'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a9xx/gcc-5.4/a9xx-bc-$version-host.tar.gz"
)

md5=\
(
    '0ad281e0ea52c97a6abcc99e6024e7b1'
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
