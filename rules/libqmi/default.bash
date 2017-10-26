version=\
(
    '1.12.8'
)

url=\
(
    "https://www.freedesktop.org/software/libqmi/libqmi-$version.tar.xz"
)

md5=\
(
    'fcad1a581ee9df8de5a753616dc27adf'
)

maintainer=\
(
    'Tiago Sá Marques <tsmarques@fe.up.pt>'
)

requires=\
(
    'glib/default'
    'libffi/default'
)

configure()
{
    export PKG_CONFIG="${cfg_dir_toolchain}/bin/pkg-config"
    export PKG_CONFIG_PATH="$cfg_dir_toolchain_sysroot/usr/lib/pkgconfig"
    ./configure \
        --prefix="$cfg_dir_rootfs/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
  	--with-sysroot="$cfg_dir_toolchain_sysroot" \
	--without-udev
}

build()
{
    export PKG_CONFIG="${cfg_dir_toolchain}/bin/pkg-config"
    export PKG_CONFIG_PATH="$cfg_dir_toolchain_sysroot/usr/lib/pkgconfig"
    $cmd_make CC=$cmd_target_cc
}

target_install()
{
    $cmd_make install
    $cmd_cp "$cfg_dir_toolchain_sysroot"/usr/lib/libffi.* "$cfg_dir_rootfs"/usr/lib/
    $cmd_cp "$cfg_dir_toolchain_sysroot"/usr/lib/libgio* "$cfg_dir_rootfs"/usr/lib/
    $cmd_cp "$cfg_dir_toolchain_sysroot"/usr/lib/libgmodule* "$cfg_dir_rootfs"/usr/lib/
    $cmd_cp "$cfg_dir_toolchain_sysroot"/usr/lib/libgobject* "$cfg_dir_rootfs"/usr/lib/
    $cmd_cp "$cfg_dir_toolchain_sysroot"/usr/lib/libglib* "$cfg_dir_rootfs"/usr/lib/
}
