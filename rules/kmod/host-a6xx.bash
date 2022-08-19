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
    "https://www.lsts.pt/glued/cloud/package/lctr-a6xx/gcc-5.4/a6xx-kmod-$version-host.tar.gz"
)

md5=\
(
    '6f8575e48c2d2a09b5f88d09c2b44f6b'
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
