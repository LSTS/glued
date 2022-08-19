version=\
(
    "v2.5.2"
)

requires=\
(
    'bison/rpi4-host'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/gcc-5.4/rpi4-ftjam-${version}-host.tar.gz"
)

md5=\
(
    "9bc7d41462cf52cc15e302a24522ee38"
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
