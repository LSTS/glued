version=\
(
    'v2015.67'
)

requires=\
(
    'zlib/a9xx'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a9xx/gcc-5.4/dropbear-$version.tar.gz"
)

md5=\
(
    'afbb4119341f1a6e8a556635bfa70ec8'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
