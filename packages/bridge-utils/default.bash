version=\
(
    "1.4"
)

url=\
(
    "http://downloads.sourceforge.net/project/bridge/bridge/bridge-utils-$version/bridge-utils-$version.tar.gz"
)

md5=\
(
    "0182fcac3a2b307113bbec34e5f1c673"
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

post_unpack()
{
    cd ../bridge-utils-$version && autoreconf
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
