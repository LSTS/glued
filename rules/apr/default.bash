version=\
(
    '1.5.1'
)

url=\
(
    "http://www.eu.apache.org/dist/apr/apr-$version.tar.bz2"
)

md5=\
(
    'ffee70a111fd07372982b0550bbb14b7'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
    export ac_cv_file__dev_zero='yes'
    export ac_cv_func_setpgrp_void='yes'
    export apr_cv_process_shared_works='yes'
    export apr_cv_mutex_robust_shared='no'
    export apr_cv_tcp_nodelay_with_cork='yes'
    export ac_cv_sizeof_struct_iovec='8'
    export apr_cv_mutex_recursive='yes'

    "../apr-$version/configure" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --disable-static
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
    # Libs:
    for f in "$cfg_dir_toolchain_sysroot/usr/lib/libapr"*".so"*; do
        if [ -L "$f" ]; then
            $cmd_cp "$f" "$cfg_dir_rootfs/usr/lib"
        else
            $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
        fi
    done
}
