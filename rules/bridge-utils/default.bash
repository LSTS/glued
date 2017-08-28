version=\
(
    '1.6'
)

url=\
(
    "http://www.kernel.org/pub/linux/utils/net/bridge-utils/bridge-utils-$version.tar.gz"
)

md5=\
(
    'f369e90e85e4bb46baa26a7b9d66b578'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

post_unpack()
{
    patches=$(ls "$pkg_dir/patches-$version/"*.patch 2>/dev/null)
    if [ -n "$patches" ]; then
        cat $patches | patch -p1
    fi &&

    autoreconf
}

configure()
{
    cd ../bridge-utils-$version &&
    ./configure \
        --prefix="$cfg_dir_rootfs/usr" \
        --target=$cfg_target_canonical \
        --host=$cfg_target_canonical \
        --build=$cfg_host_canonical
}

build()
{
    cd ../bridge-utils-$version &&
    $cmd_make
}

target_install()
{
    cd ../bridge-utils-$version &&
    $cmd_target_strip brctl/brctl -o $cfg_dir_rootfs/usr/bin/brctl
}
