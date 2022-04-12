version=\
(
    "1.4.14"
)

url=\
(
    "http://ftp.netfilter.org/pub/iptables/iptables-$version.tar.bz2"
)

md5=\
(
    "5ab24ad683f76689cfe7e0c73f44855d"
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

configure()
{
    mkdir -p $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot/usr
    export cfg_dir_output_toolchain_sysroot=$cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot
    ../iptables-$version/configure \
        --prefix="$cfg_dir_output_toolchain_sysroot/usr" \
        --target=$cfg_target_canonical \
        --host=$cfg_target_canonical \
        --build=$cfg_host_canonical \
        --disable-shared \
        --enable-static
}

build()
{
    $cmd_make
}

target_install()
{
    mkdir -p $cfg_dir_builds/$pkg/rootfs/usr/sbin
    export cfg_dir_output_rootfs=$cfg_dir_builds/$pkg/rootfs

    $cmd_target_strip iptables/xtables-multi -o $cfg_dir_output_rootfs/usr/sbin/xtables-multi &&
    ln -fs xtables-multi $cfg_dir_output_rootfs/usr/sbin/iptables
    ln -fs xtables-multi $cfg_dir_output_rootfs/usr/sbin/iptables-save
    ln -fs xtables-multi $cfg_dir_output_rootfs/usr/sbin/iptables-restore
    ln -fs xtables-multi $cfg_dir_output_rootfs/usr/sbin/ip6tables
    ln -fs xtables-multi $cfg_dir_output_rootfs/usr/sbin/ip6tables-save
    ln -fs xtables-multi $cfg_dir_output_rootfs/usr/sbin/ip6tables-restore

    tar -czf ../iptables-v$version.tar.gz ../rootfs
}
