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
    'bash/a6xx'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a6xx/gcc-5.4/a6xx-glued-apk-${version}.tar.gz"
)

md5=\
(
    "57415eee2ee15779a79c59b6af2be0a6"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}

