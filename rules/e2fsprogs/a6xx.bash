version=\
(
    'v1.42.13'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a6xx/gcc-5.4/a6xx-e2fsprogs-$version.tar.gz"
)

md5=\
(
    '75034df9e910460396e9aa2425dd6ac9'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
