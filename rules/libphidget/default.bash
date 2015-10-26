version=\
(
    '2.1.8.20150410'
)

url=\
(
    "http://www.phidgets.com/downloads/libraries/libphidget_$version.tar.gz"
)

md5=\
(
    'a1ee9be405179370767d70c8304c3ac8'
)

maintainer=\
(
    'Kristian Klausen <kristian.klausen@itk.ntnu.no>'
)

requires=\
(
    'libusb'
)

configure()
{
    export PKG_CONFIG="${cfg_dir_toolchain}/bin/pkg-config"
    export PKG_CONFIG_PATH="$cfg_dir_toolchain_sysroot/usr/lib/pkgconfig"
    "../libphidget-$version/configure" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" 
}

build()
{
    $cmd_make
}

host_install()
{
    export PKG_CONFIG="${cfg_dir_toolchain}/bin/pkg-config"
    export PKG_CONFIG_PATH="$cfg_dir_toolchain_sysroot/usr/lib/pkgconfig"
    $cmd_make install
}

target_install()
{
    cp -a "$cfg_dir_toolchain_sysroot/usr/lib/libphidget"*.so* "$cfg_dir_rootfs/lib" &&
    $cmd_target_strip "$cfg_dir_rootfs/lib/libphidget"*.so*
}


