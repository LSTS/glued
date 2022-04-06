version=\
(
    '0.10.0'
)

url=\
(
    "http://www.eu.apache.org/dist/logging/log4cxx/0.10.0/apache-log4cxx-0.10.0.tar.gz"
)

md5=\
(
    'b30ffb8da3665178e68940ff7a61084c'
)

requires=\
(
    'apr/default'
    'apr-util/default'
)

post_unpack()
{
    patches=$(ls "$pkg_dir/patches-$version/"*.patch 2>/dev/null)
    if [ -n "$patches" ]; then
        cat $patches | patch -p1
    fi
}

configure()
{
    ./configure \
        --prefix="${cfg_dir_toolchain_sysroot}/usr"        \
        --target=${cfg_target_canonical} \
        --host=${cfg_target_canonical}   \
        --build=${cfg_host_canonical}    \
        --with-apr="${cfg_dir_toolchain_sysroot}/usr"      \
        --with-apr-util="${cfg_dir_toolchain_sysroot}/usr" \
        --enable-shared                  \
        --disable-static                 \
        ac_cv_file__dev_zero=yes         \
        ac_cv_func_setpgrp_void=yes      \
        apr_cv_tcp_nodelay_with_cork=no  \
        apr_cv_process_shared_works=no   \
        apr_cv_mutex_robust_shared=no    \
        ac_cv_sizeof_struct_iovec=8
}

build()
{
    $cmd_make
}

host_install()
{
    cd ../log4cpp
    $cmd_make install
}

target_install()
{
    # Libs:
    for f in "$cfg_dir_toolchain_sysroot/usr/lib/"liblog4cxx*.so*; do
        if [ -L "$f" ]; then
            $cmd_cp "$f" "$cfg_dir_rootfs/usr/lib"
        else
            $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
        fi
    done
}
