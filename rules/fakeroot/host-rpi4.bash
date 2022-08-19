version=\
(
    '1.12.2'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(

    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/gcc-5.4/rpi4-fakeroot-v${version}-host.tar.gz"
)

md5=\
(
    '01b97d15f6ea659834045e8f2de7da29'
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
