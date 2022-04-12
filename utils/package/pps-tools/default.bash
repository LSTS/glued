version=\
(
    '1.0.3'
)

url=\
(
    "https://github.com/redlab-i/pps-tools/archive/refs/tags/v$version.tar.gz"
)

md5=\
(
    '9b18c55efe020d02c26cd8c759ac258d'
)

post_unpack()
{
    patches=$(ls "$pkg_dir"/patches/*.patch)

    if [ -n "$patches" ]; then
        cat $patches | patch -p1
    fi
}

#configure()
#{
#}

build()
{
    CC="$cmd_target_cc" $cmd_make
}

host_install()
{
    mkdir -p $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot
    export cfg_dir_output_toolchain_sysroot=$cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot
    CC="$cmd_target_cc" \
        SYSROOT="$cfg_dir_toolchain_sysroot" \
        DESTDIR="$cfg_dir_output_toolchain_sysroot" \
        $cmd_make install
}

target_install()
{
    mkdir -p $cfg_dir_builds/$pkg/rootfs/
    export cfg_dir_output_rootfs=$cfg_dir_builds/$pkg/rootfs
    CC="$cmd_target_cc" \
        SYSROOT="$cfg_dir_rootfs" \
        DESTDIR="$cfg_dir_output_rootfs" \
        $cmd_make install

    tar -czf ../pps-tools-v$version.tar.gz ../rootfs ../toolchain
}
