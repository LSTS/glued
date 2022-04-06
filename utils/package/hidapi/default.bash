version=\
(
    '0.8.0-rc1'
)

url=\
(
    "https://github.com/signal11/hidapi/archive/hidapi-$version.tar.gz"
)

md5=\
(
    '069f9dd746edc37b6b6d0e3656f47199'
)

maintainer=\
(
    'Ricardo Martins <rasm@oceanscan-mst.com>'
)

requires=\
(
    'libtool/host'
    'libusb/default'
    'systemd/default'
)

post_unpack()
{
    patches=$(ls "$pkg_dir/patches/"*.patch)
    if [ -n "$patches" ]; then
        cat $patches | patch -p1
    fi
}

configure()
{
    cd "../hidapi-hidapi-$version" &&
        ./bootstrap

    ./configure \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical"
}

build()
{
    $cmd_make -C "../hidapi-hidapi-$version"
}

host_install()
{
    $cmd_make -C "../hidapi-hidapi-$version" install
}

target_install()
{
    $cmd_cp \
        "$cfg_dir_toolchain_sysroot/usr/lib/libhidapi"*.so* \
        "$cfg_dir_rootfs/lib" &&

    $cmd_target_strip \
            "$cfg_dir_rootfs/lib/libhidapi"*.so*
}
