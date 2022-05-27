version=\
(
    'v1.46.4'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4x64/gcc-5.4/e2fsprogs-$version.tar.gz"
)

md5=\
(
    '14392d74953e508a37c9e6e2f47de95e'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
