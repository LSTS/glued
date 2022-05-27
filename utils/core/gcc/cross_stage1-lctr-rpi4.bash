source $pkg_common

requires=\
(
    'core/binutils/cross'
    'core/autoconf/host'
    'core/mpfr/host'
    'core/gmp/host'
    'core/mpc/host'
)

configure()
{
    MAKEINFO='/bin/true' \
    "../gcc-$version/configure" $cfg_target_gcc_configure_flags \
        --target="$cfg_target_canonical" \
        --host="$cfg_host_canonical" \
        --build="$cfg_host_canonical" \
        --prefix="$cfg_dir_toolchain" \
        --with-mpfr="$cfg_dir_toolchain" \
        --with-gmp="$cfg_dir_toolchain" \
        --with-mpc="$cfg_dir_toolchain" \
        --without-headers \
        --disable-shared \
        --disable-threads \
        --disable-libatomic \
        --disable-libssp \
        --disable-libgomp \
        --disable-libmudflap \
        --disable-libquadmath \
        --with-newlib \
        --enable-poison-system-directories \
        --enable-target-optspace \
        --enable-languages=c \
        --disable-decimal-float \
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
