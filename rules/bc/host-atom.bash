version=\
(
    'v1.06'
)

requires=\
(
    'flex/host-atom'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-atom/gcc-5.4/atom-bc-$version-host.tar.gz"
)

md5=\
(
    'b6ee32ef45b7d29a92bd787bfd3e650b'
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
