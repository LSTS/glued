version=\
(
    '1.0'
)

url=\
(
    "http://www.lsts.pt/glued/uswitch-$version.tar.bz2"
)

md5=\
(
    'a5cf6a20be8677d30b60a0bc649c6cf8'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'libusbx/default'
)

build()
{
    $cmd_make CC="$cmd_target_cc"
}

target_install()
{
    $cmd_target_strip uswitch -o "$cfg_dir_rootfs/usr/bin/uswitch"
}
