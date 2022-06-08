version=\
(
    'v1.0.0'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

requires=\
(
    'bash/atom'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-atom/gcc-5.4/glued-apk-${version}.tar.gz"
)

md5=\
(
    "93231d5c1113b26be3e2073edb1c16ba"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}

