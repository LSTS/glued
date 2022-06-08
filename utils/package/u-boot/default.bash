version=\
(
    '2014.07'
)

url=\
(
    "ftp://ftp.denx.de/pub/u-boot/u-boot-$version.tar.bz2"
)

md5=\
(
    '36d4bad687edcafa396fee607e505d4e'
)

post_unpack()
{
    patches=$(ls "$pkg_dir/patches/$version/"*.patch\
	"$cfg_dir_system/patches/u-boot/$version/"*.patch 2>/dev/null)
    if [ -n "$patches" ]; then
        cat $patches | patch -p1
    fi
}

configure()
{
    $cmd_make \
        "${cfg_target_uboot_config}_config"
}

build()
{
    $cmd_make \
        CROSS_COMPILE="$cfg_target_canonical"-
}

host_install()
{
    mkdir -p $cfg_dir_builds/$pkg/toolchain/bin
    export cfg_dir_output_toolchain=$cfg_dir_builds/$pkg/toolchain/
    $cmd_cp \
        tools/mkimage \
        "$cfg_dir_output_toolchain/bin"
}

target_install()
{
    mkdir $cfg_dir_builds/$pkg/rootfs
    export cfg_dir_output_rootfs=$cfg_dir_builds/$pkg/rootfs

    $cmd_mkdir "$cfg_dir_output_rootfs/boot"

    for f in MLO u-boot.img u-boot.bin; do
        if [ -f "$f" ]; then
            $cmd_cp "$f" "$cfg_dir_output_rootfs/boot"
        fi
    done

    tar -czf ../u-boot-v$version.tar.gz ../rootfs ../toolchain
}
