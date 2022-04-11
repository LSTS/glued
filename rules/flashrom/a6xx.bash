version=\
(
    'v0.9.5.2'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a6xx/gcc-5.4/flashrom-${version}.tar.gz"
)

md5=\
(
    "277697f6f1fe6fe2634db527d6605dc3"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
