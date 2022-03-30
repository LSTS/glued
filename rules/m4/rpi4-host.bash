version=\
(
    'v1.4.19'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/m4-${version}-host.tar.gz"
)

md5=\
(
    "91cdfa8ac06ed3f5ea624ce5218cd97b"
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
