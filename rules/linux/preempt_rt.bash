. "$cfg_dir_rules/$pkg/default.bash"

version=\
(
    '3.14.58'
)

version_rt=\
(
    "$version-rt59"
)

url=\
(
    "https://www.kernel.org/pub/linux/kernel/v3.x/linux-$version.tar.xz"
    "https://www.kernel.org/pub/linux/kernel/projects/rt/3.14/older/patch-$version_rt.patch.xz"
)

md5=\
(
    '98e68ad6e8e1d399708b6846e335519c'
    '803414473c1f421e546f276a6893a2cd'
)

post_unpack()
{
    # Normal post-unpack from default
    echo "Patching Linux"
    patches=$(ls "$pkg_dir/patches/$version/"*.patch\
	"$cfg_dir_system/patches/linux/$version/"*.patch 2>/dev/null)
    if [ -n "$patches" ]; then
        cat $patches | patch -p1
    fi

    if [ -d "$cfg_dir_toolchain/firmware" ]; then
        tar -C "$cfg_dir_toolchain/firmware" -c -v -f - . | tar -C firmware -x -v -f -
    fi
    
    
    echo "Patching Real-time"
    
    file=$(basename "${url[1]}")        
    xz -d -c "$cfg_dir_downloads/$file" | patch -p1
    
}

configure()
{
    $cmd_make \
        ARCH=${cfg_target_linux} \
        mrproper &&

    cp "$cfg_dir_system/cfg/linux-${version}.cfg" .config && 
    echo "Config copy successful" && 
    
    cat "$cfg_dir_system/cfg/linux-${version_rt}.cfg" >> .config && 
    echo "RT config application successful" &&
    
    if [ -f "$cfg_dir_system/files/initramfs_init.sh" ]; then
        $cmd_mkdir initramfs &&
        $cmd_cp "$pkg_dir/files/initramfs.conf" . &&
        $cmd_cp "$cfg_dir_system/files/initramfs_init.sh" initramfs/init.sh &&
        $cmd_cp "$cfg_dir_rootfs/bin/busybox" initramfs/busybox
    fi

    yes '' | $cmd_make \
        CROSS_COMPILE=${cfg_target_canonical}- \
        ARCH=${cfg_target_linux} \
        oldconfig
}
