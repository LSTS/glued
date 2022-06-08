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
    'bash/a9xx'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a9xx/gcc-5.4/glued-apk-${version}.tar.gz"
)

md5=\
(
    "39441c4c51f345f167fff4ddf6ba5e37"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}

