version=\
(
    '1.3.12'
)

url=\
(
    "http://www.eu.apache.org/dist/apr/apr-util-$version.tar.bz2"
)

md5=\
(
    '0f671b037ca62751a8a7005578085560'
)

requires=\
(
    'apr/ros'
)

configure()
{
    cd apr-util-${version}
    ./configure \
        --prefix="${cfg_dir_toolchain_sysroot}/usr" \
        --target="${cfg_target_canonical}" \
        --host="${cfg_target_canonical}" \
        --build="${cfg_host_canonical}" \
        --enable-shared \
        --disable-static \
        --without-pgsql \
        --without-sqlite2 \
        --without-sqlite3 \
        --with-apr="${cfg_dir_toolchain_sysroot}/usr" \
        --with-expat=builtin \
        ac_cv_file__dev_zero=yes \
        ac_cv_func_setpgrp_void=yes \
        apr_cv_tcp_nodelay_with_cork=no \
        apr_cv_process_shared_works=no \
        apr_cv_mutex_robust_shared=no \
        ac_cv_sizeof_struct_iovec=8
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
    # Libs: @todo
    for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libaprutil-*; do
        if [ -L "$f" ]; then
            $cmd_cp "$f" "$cfg_dir_rootfs/usr/lib"
        else
            $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
        fi
    done
}
