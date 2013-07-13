version=\
(
    "2.6.0"
)

url=\
(
    "ftp://ftp.netperf.org/netperf/netperf-${version}.tar.bz2"
)

md5=\
(
    "9654ffdfd4c4f2c93ce3733cd9ed9236"
)

configure()
{
    echo "ac_cv_func_setpgrp_void=yes" > config.cache
    ../netperf-$version/configure \
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
  cp "${cfg_dir_toolchain_sysroot}/usr/bin/${cfg_target_canonical}-netperf" "${cfg_dir_rootfs}/usr/bin/netperf"
  cp "${cfg_dir_toolchain_sysroot}/usr/bin/${cfg_target_canonical}-netserver" "${cfg_dir_rootfs}/usr/bin/netserver"
}


