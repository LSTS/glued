version=\
(
    'v1.06'
)

requires=\
(
    'flex/host-rpi2.3'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi2.3/gcc-5.4/bc-$version-host.tar.gz"
)

md5=\
(
    'f5a2bf0b8ac4773ed0571385228abd20'
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
