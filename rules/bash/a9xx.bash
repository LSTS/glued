version=\
(
    "v4.4.18"
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a9xx/gcc-5.4/a9xx-bash-${version}.tar.gz"
)

md5=\
(
    "81178b56463d313feef2591ab826dc5e"
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}
