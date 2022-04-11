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
    'libusb/a6xx'
)

build()
{
    $cmd_make CC="$cmd_target_cc"
}

target_install()
{
    mkdir -p $cfg_dir_builds/$pkg/rootfs/usr/bin
    export cfg_dir_output_rootfs=$cfg_dir_builds/$pkg/rootfs

    $cmd_target_strip uswitch -o "$cfg_dir_output_rootfs/usr/bin/uswitch"
    tar -czf ../uswitch-v$version.tar.gz ../rootfs
}
