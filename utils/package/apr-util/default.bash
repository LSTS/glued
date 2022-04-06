version=\
(
    '1.5.3'
)

url=\
(
    "http://archive.apache.org/dist/apr/apr-util-$version.tar.bz2"
)

md5=\
(
    '6f3417691c7a27090f36e7cf4d94b36e'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'apr/default'
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

    "../apr-util-$version/configure" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --with-apr="$cfg_dir_toolchain_sysroot/usr" \
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
    for f in "$cfg_dir_toolchain_sysroot/usr/lib/libaprutil"*".so"*; do
        if [ -L "$f" ]; then
            $cmd_cp "$f" "$cfg_dir_rootfs/usr/lib"
        else
            $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
        fi
    done
}
