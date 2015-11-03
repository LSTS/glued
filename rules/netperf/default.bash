version=\
(
    '2.7.0'
)

url=\
(
    "ftp://ftp.netperf.org/netperf/netperf-${version}.tar.bz2"
)

md5=\
(
    'ad1c5342d61f297c417a93133aeba65a'
)

configure()
{
    echo "ac_cv_func_setpgrp_void=yes" > config.cache
    "../netperf-$version/configure" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
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
