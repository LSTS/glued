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
    'bash/rpi4x64'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4x64/gcc-5.4/rpi4x64-glued-apk-${version}.tar.gz"
)

md5=\
(
    "79e459571515d510cfe6d05da0b98b2d"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}

