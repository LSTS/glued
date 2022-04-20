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
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi2.3/gcc-5.4/kmod-$version-host.tar.gz"
)

md5=\
(
    '72a66e7ba8174a890a77b000180eeeb4'
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
