version=\
(
    '1.0.20'
)

url=\
(
    "http://downloads.sourceforge.net/libusb/libusb-$version.tar.bz2"
)

md5=\
(
    '1d4eb194eaaa2bcfbba28102768c7dbf'
)

maintainer=\
(
    'Ricardo Martins <rasm@oceanscan-mst.com>'
)

configure()
{
    mkdir $cfg_dir_builds/$pkg/toolchain
    mkdir $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical
    mkdir $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot
    mkdir $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot/usr
    mkdir $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot/usr/lib
    export cfg_dir_output_toolchain_sysroot=$cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot
    export cfg_dir_output_toolchain=$cfg_dir_builds/$pkg/toolchain

    export PKG_CONFIG="${cfg_dir_toolchain}/bin/pkg-config"
    export PKG_CONFIG_PATH="$cfg_dir_toolchain_sysroot/usr/lib/pkgconfig"
    "../libusb-$version/configure" \
        --prefix="$cfg_dir_output_toolchain_sysroot/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --disable-udev \
        --disable-static \
        --enable-shared
}

build()
{
    $cmd_make -j1
}

host_install()
{
    export PKG_CONFIG="${cfg_dir_output_toolchain}/bin/pkg-config"
    export PKG_CONFIG_PATH="$cfg_dir_output_toolchain_sysroot/usr/lib/pkgconfig"
    $cmd_make -j1 install
}

target_install()
{
    mkdir $cfg_dir_builds/$pkg/rootfs
    mkdir $cfg_dir_builds/$pkg/rootfs/usr
    mkdir $cfg_dir_builds/$pkg/rootfs/usr/lib
    export cfg_dir_output_rootfs=$cfg_dir_builds/$pkg/rootfs/usr

    cp -a "$cfg_dir_output_toolchain_sysroot/usr/lib/libusb"*.so* "$cfg_dir_output_rootfs/lib" &&
    $cmd_target_strip "$cfg_dir_output_rootfs/lib/libusb"*.so*

    tar -czf ../libusb-v$version.tar.gz ../rootfs ../toolchain
}
