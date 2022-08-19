version=\
(
    'v2.3.4'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4x64/gcc-5.4/rpi4x64-nfs-utils-$version.tar.gz"
)

requires=\
(
    'libtirpc/rpi4x64'
)

md5=\
(
    'b978981f9847bd202c1584a29fe202fb'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
