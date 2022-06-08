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
    "https://www.lsts.pt/glued/cloud/package/lctr-a9xx/gcc-5.4/flex-$version-host.tar.gz"
)

md5=\
(
    '2e5220a1d0e64e3a0ea9d94a8c9e9bca'
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
