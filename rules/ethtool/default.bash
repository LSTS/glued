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
    ../ethtool-${version}/configure \
        --prefix="${cfg_dir_toolchain_sysroot}/usr" \
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
    cp -a "${cfg_dir_toolchain_sysroot}/usr/sbin/ethtool" "${cfg_dir_rootfs}/usr/sbin/" &&
    $cmd_target_strip "${cfg_dir_rootfs}/usr/sbin/ethtool" 
}


