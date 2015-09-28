version=\
(
    '221'
)

url=\
(
    "http://www.freedesktop.org/software/systemd/systemd-$version.tar.xz"
)

md5=\
(
    'b4d5a253841cf28a98b7ec99c45e3716'
)

maintainer=\
(
    'Ricardo Martins <rasm@oceanscan-mst.com>'
)

requires=\
(
    'gperf/host'
    'libcap/default'
    'kmod/default'
    'util-linux/default'
)

configure()
{
    export PKG_CONFIG="${cfg_dir_toolchain}/bin/pkg-config"
    export PKG_CONFIG_PATH="$cfg_dir_toolchain_sysroot/usr/lib/pkgconfig"
    export ac_cv_func_malloc_0_nonnull=yes
    export ac_cv_func_realloc_0_nonnull=yes
    "../systemd-$version/configure" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --exec-prefix="$cfg_dir_toolchain_sysroot/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --with-rootprefix="$cfg_dir_toolchain_sysroot/usr" \
        --with-sysvinit-path="$cfg_dir_toolchain_sysroot/usr/etc/init.d" \
        --disable-maintainer-mode \
        --disable-gnuefi \
        --disable-gcrypt \
        --disable-nls \
        --disable-python-devel \
        --disable-introspection \
        --disable-gudev \
        --disable-xz \
        --with-gnu-ld \
        --disable-manpages \
        --disable-efi \
        --disable-networkd \
        cc_cv_CFLAGS__flto=no
}

build()
{
    $cmd_make -j1 V=1
}

host_install()
{
    export PKG_CONFIG="${cfg_dir_toolchain}/bin/pkg-config"
    export PKG_CONFIG_PATH="$cfg_dir_toolchain_sysroot/usr/lib/pkgconfig"
    $cmd_make install
}

# target_install()
# {
#     cp -a "$cfg_dir_toolchain_sysroot/usr/lib/libusb"*.so* "$cfg_dir_rootfs/lib" &&
#     $cmd_target_strip "$cfg_dir_rootfs/lib/libusb"*.so*
# }
