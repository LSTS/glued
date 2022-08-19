version=\
(
    'v1.6'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a9xx/gcc-5.4/a9xx-bridge-utils-$version.tar.gz"
)

md5=\
(
    'ab3a92a1b5418088dd5da36c0cb04e73'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
