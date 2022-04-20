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
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi2.3/gcc-5.4/flex-$version-host.tar.gz"
)

md5=\
(
    '70f7207d27f6ad2dd973d67a5473cdda'
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
