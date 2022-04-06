source $pkg_common

requires=\
(
    'glibc/headers'
)

configure()
{
    MAKEINFO='/bin/true' \
    "../gcc-$version/configure" $cfg_target_gcc_configure_flags \
        --prefix="$cfg_dir_toolchain" \
        --with-build-sysroot="$cfg_dir_toolchain_sysroot" \
        --with-sysroot="$cfg_dir_toolchain_sysroot" \
        --target="$cfg_target_canonical" \
        --host="$cfg_host_canonical" \
        --build="$cfg_host_canonical" \
        --with-mpfr="$cfg_dir_toolchain" \
        --with-gmp="$cfg_dir_toolchain" \
        --with-mpc="$cfg_dir_toolchain" \
        --disable-libssp \
        --disable-libgomp \
        --disable-libmudflap \
        --disable-libquadmath \
        --disable-libatomic \
        --enable-languages=c \
        --disable-multilib \
        --disable-nls
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}
