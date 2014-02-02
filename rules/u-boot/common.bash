post_unpack()
{
    patches=$(ls "$cfg_package_spec_dir/patches-$version/"*.patch\
	"$cfg_dir_system/patches/u-boot/patches-${version}/"*.patch 2>/dev/null)
    if [ -n "$patches" ]; then
        cat $patches | patch -p1
    fi
}

configure()
{
    $cmd_make \
        ARCH="$cfg_target_uboot_arch" \
        CROSS_COMPILE="$cfg_target_canonical"- \
        "$cfg_target_uboot_config"
}

build()
{
    $cmd_make \
        ARCH="$cfg_target_uboot_arch" \
        CROSS_COMPILE="$cfg_target_canonical"-
}

host_install()
{
    $cmd_cp \
        tools/mkimage \
        "$cfg_dir_toolchain/bin"
}

target_install()
{
    if [ -f MLO ]; then
        $cmd_cp MLO "$cfg_dir_rootfs/boot"
    fi

    if [ -f u-boot.img ]; then
        $cmd_cp u-boot.img "$cfg_dir_rootfs/boot"
    fi
}
