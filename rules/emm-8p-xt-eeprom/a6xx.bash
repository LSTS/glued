version=\
(
    'v1.0.0'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a6xx/gcc-5.4/a6xx-emm-8p-xt-eeprom-${version}.tar.gz"
)

md5=\
(
    "08135f4e82f8e137ec8469c3c0c252d9"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
