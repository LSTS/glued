version=\
(
    "4.2"
)

url=\
(
    "https://www.kernel.org/pub/software/network/ethtool/ethtool-${version}.tar.gz"
)

md5=\
(
    "5b55f7cd76e901dfc2738ac22cab96ca"
)
maintainer=\
(
    'Kristian Klausen <kristian.klausen@itk.ntnu.no>'
)

configure()
{
    mkdir -p $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot/usr
    export cfg_dir_output_toolchain_sysroot=$cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot
    ../ethtool-${version}/configure \
        --prefix="${cfg_dir_output_toolchain_sysroot}/usr" \
        --target=$cfg_target_canonical \
        --host=$cfg_target_canonical \
        --config-cache
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
    mkdir -p $cfg_dir_builds/$pkg/rootfs/usr/sbin
    export cfg_dir_output_rootfs=$cfg_dir_builds/$pkg/rootfs

    cp -a "${cfg_dir_output_toolchain_sysroot}/usr/sbin/ethtool" "${cfg_dir_output_rootfs}/usr/sbin/" &&
    $cmd_target_strip "${cfg_dir_output_rootfs}/usr/sbin/ethtool"

    tar -czf ../ethtool-v$version.tar.gz ../rootfs ../toolchain
}


