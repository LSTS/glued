version=\
(
    'v2.5.1'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/gcc-5.4/bison-${version}-host.tar.gz"
)

md5=\
(
    "e81bb4a5174c800e449a2ae0f2b852ff"
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
