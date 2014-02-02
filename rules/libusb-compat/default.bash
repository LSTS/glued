version=\
(
    '0.1.4'
)

url=\
(
    "http://downloads.sourceforge.net/libusb/libusb-compat-$version.tar.bz2"
)

md5=\
(
    '2ca521fffadd0c28fdf174e6ec73865b'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'libusbx/default'
)

post_unpack()
{
    patches=$(ls "$cfg_package_spec_dir/patches/"*.patch)
    if [ -n "$patches" ]; then
        cat $patches | patch -p1
    fi
}

configure()
{
    "../libusb-compat-$version/configure" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --disable-static \
        --enable-shared
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}

target_install()
{
    cp -a "$cfg_dir_toolchain_sysroot/usr/lib/libusb"*.so* "$cfg_dir_rootfs/lib" &&
    $cmd_target_strip "$cfg_dir_rootfs/lib/libusb"*.so*
}
