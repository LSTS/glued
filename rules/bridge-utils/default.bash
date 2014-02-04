version=\
(
    '1.5'
)

url=\
(
    "http://downloads.sourceforge.net/project/bridge/bridge/bridge-utils-$version.tar.gz"
)

md5=\
(
    'ec7b381160b340648dede58c31bb2238'
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
