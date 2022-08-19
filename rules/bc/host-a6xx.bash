version=\
(
    'v1.06'
)

requires=\
(
    'flex/host-a6xx'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a6xx/gcc-5.4/a6xx-bc-$version-host.tar.gz"
)

md5=\
(
    '9ba4849e062a0fc06cc14816a2834cd2'
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
