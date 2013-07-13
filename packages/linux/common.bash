post_unpack()
{
    patches=$(ls "$cfg_package_spec_dir/patches-$version/"*.patch\
	"$cfg_dir_system/patches/linux/patches-${version}/"*.patch 2>/dev/null)
    if [ -n "$patches" ]; then
        cat $patches | patch -p1
    fi
}

refresh()
{
    for rule in configure build target_install; do
        if [ "$cfg_dir_system/linux-${version}.cfg" -nt "$cfg_dir_builds/linux/$PKG_VAR/.$rule" ]; then
            rm "$cfg_dir_builds/linux/$PKG_VAR/.$rule"
        fi
    done
}

configure()
{
    $cmd_make \
        ARCH=${cfg_target_linux} \
        mrproper &&
    cp "$cfg_dir_system/linux-${version}.cfg" .config &&
    yes '' | $cmd_make \
        CROSS_COMPILE=${cfg_target_canonical}- \
        ARCH=${cfg_target_linux} \
        oldconfig
}

build()
{
    if [ -n "$cfg_target_linux_load_addr" ]; then
        export LOADADDR="$cfg_target_linux_load_addr"
    fi

    $cmd_make \
        CROSS_COMPILE=$cfg_target_canonical- \
        ARCH=$cfg_target_linux &&
    $cmd_make \
        CROSS_COMPILE=$cfg_target_canonical- \
        ARCH=$cfg_target_linux \
        modules &&

    if [ "$(basename $cfg_target_linux_kernel)" = 'uImage' ]; then
        $cmd_make \
            CROSS_COMPILE=$cfg_target_canonical- \
            ARCH=$cfg_target_linux \
            uImage
    fi

    if [ -n "${cfg_target_linux_size}" ]; then
        dd if="$cfg_target_linux_kernel" of="${cfg_target_linux_kernel}.padded" \
            ibs="${cfg_target_linux_size}" conv=sync &&
        mv "${cfg_target_linux_kernel}.padded" "${cfg_target_linux_kernel}"
    fi
}

target_install()
{
    kernel="$cfg_dir_base/${cfg_sys_family}/glued-${cfg_glued_version}-${cfg_sys_family}-kernel.bin"

    if [ -n "$(file "$cfg_target_linux_kernel" | grep ELF)" ]; then
        strip="$(echo $cfg_dir_toolchain/bin/*-strip)"
        $strip -s -R .comment "$cfg_target_linux_kernel"
    fi

    case "$cfg_target_linux_kernel_compress" in
        gzip)
            gzip "$cfg_target_linux_kernel" -c > "$kernel"
            ;;
        *)
            cp -v "$cfg_target_linux_kernel" "$kernel"
            ;;
    esac

    if [ -z "$cfg_target_linux_kernel_standalone" ]; then
        cp "$kernel" $cfg_dir_rootfs/boot/kernel
    fi

    $cmd_make \
        CROSS_COMPILE="$cfg_target_canonical-" \
        ARCH="$cfg_target_linux" \
        INSTALL_MOD_PATH="$cfg_dir_rootfs/usr" \
        modules_install

    $cmd_make \
        CROSS_COMPILE="$cfg_target_canonical-" \
        ARCH="$cfg_target_linux" \
        INSTALL_MOD_PATH="$cfg_dir_rootfs/usr" \
        firmware_install
}
