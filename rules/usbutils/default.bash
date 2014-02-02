version=\
(
    '006'
)

url=\
(
    "https://www.kernel.org/pub/linux/utils/usb/usbutils/usbutils-$version.tar.xz"
)

md5=\
(
    'c9aa14ee3d6c991fda183f42cf72a8a8'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'libusbx/default'
)

configure()
{
    export PKG_CONFIG="${cfg_dir_toolchain}/bin/pkg-config"
    export PKG_CONFIG_PATH="$cfg_dir_toolchain_sysroot/usr/lib/pkgconfig"
    export PKG_CONFIG_SYSROOT_DIR="/"
    export LIBUSB_CFLAGS="$(${PKG_CONFIG} --cflags libusb-1.0 )"
    "../usbutils-$version/configure" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --prefix="/usr"
}

build()
{
    $cmd_make
}

host_install()
{
    export PKG_CONFIG="${cfg_dir_toolchain}/bin/pkg-config"
    export PKG_CONFIG_PATH="$cfg_dir_toolchain_sysroot/usr/lib/pkgconfig"
    $cmd_make prefix="$cfg_dir_toolchain_sysroot/usr" install &&
    ( test -e "${cfg_dir_toolchain_sysroot}/usr/share/pkgconfig/usbutils.pc" && mv "${cfg_dir_toolchain_sysroot}/usr/share/pkgconfig/usbutils.pc" ${PKG_CONFIG_PATH} ) 
    rmdir --ignore-fail-on-non-empty "${cfg_dir_toolchain_sysroot}/usr/share/pkgconfig"
}

target_install()
{
    $cmd_make \
        prefix="$cfg_dir_rootfs/usr" \
        install &&
    rm -rf "$cfg_dir_rootfs/usr/sbin/update-usbids.sh" \
        "$cfg_dir_rootfs/usr/share/man" \
        "$cfg_dir_rootfs/usr/share/pkgconfig"
}
