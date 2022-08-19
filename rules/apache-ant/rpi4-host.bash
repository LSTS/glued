version=\
(
    'v1.9.3'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/gcc-5.4/rpi4-apache-ant-${version}-host.tar.gz"
)

md5=\
(
    "02fb5769f77508bda671c7401b443380"
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
