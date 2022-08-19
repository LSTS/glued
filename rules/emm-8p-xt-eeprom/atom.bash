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
    "https://www.lsts.pt/glued/cloud/package/lctr-atom/gcc-5.4/atom-emm-8p-xt-eeprom-${version}.tar.gz"
)

md5=\
(
    "c583e712b5008da047e478a488748b49"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
