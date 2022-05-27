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
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4x64/gcc-5.4/flex-$version-host.tar.gz"
)

md5=\
(
    '4e9e3047f6a5c52cc16fc616aaae38c8'
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
