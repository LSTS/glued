version=\
(
    "1.05"
)

url=\
(
    "http://sourceforge.net/projects/sshpass/files/sshpass/${version}/sshpass-${version}.tar.gz"
)

md5=\
(
    "c52d65fdee0712af6f77eb2b60974ac7"
)

configure()
{
    mkdir $cfg_dir_builds/$pkg/toolchain
    mkdir $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical
    mkdir $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot
    mkdir $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot/usr
    mkdir $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot/usr/bin
    export cfg_dir_output_toolchain_sysroot=$cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot

    export ac_cv_func_malloc_0_nonnull=yes
    ./configure \
        --prefix="$cfg_dir_output_toolchain_sysroot/usr" \
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
    $cmd_make install
}

target_install()
{
    mkdir $cfg_dir_builds/$pkg/rootfs
    mkdir $cfg_dir_builds/$pkg/rootfs/bin
    export cfg_dir_output_rootfs=$cfg_dir_builds/$pkg/rootfs

    $cmd_target_strip "$cfg_dir_output_toolchain_sysroot/usr/bin/sshpass" -o "$cfg_dir_output_rootfs/bin/sshpass"

    tar -czf ../sshpass-v$version.tar.gz ../rootfs ../toolchain
}
