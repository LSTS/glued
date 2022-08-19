version=\
(
    'v1.45.6'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a9xx/gcc-5.4/a9xx-e2fsprogs-$version.tar.gz"
)

md5=\
(
    'aa01cb8397ce8b97a929fd1cd17c93e6'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
