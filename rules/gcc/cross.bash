source $pkg_common

requires=\
(
    'glibc/cross'
)

configure()
{
    MAKEINFO='/bin/true' \
    "../gcc-$version/configure" $cfg_target_gcc_configure_flags \
        --target="$cfg_target_canonical" \
        --prefix="$cfg_dir_toolchain" \
        --with-build-sysroot="$cfg_dir_toolchain_sysroot" \
        --with-sysroot="$cfg_dir_toolchain_sysroot" \
        --with-mpfr="$cfg_dir_toolchain" \
        --with-gmp="$cfg_dir_toolchain" \
        --with-mpc="$cfg_dir_toolchain" \
        --enable-__cxa_atexit \
        --disable-libssp \
        --disable-libgomp \
        --disable-libmudflap \
        --disable-nls \
        --disable-multilib \
        --enable-languages=c,c++
}

build()
{
    $cmd_make
}

host_install()
{
    libdir=lib
    if [ -d "$cfg_dir_toolchain/$cfg_target_canonical/lib64" ]; then
        libdir=lib64
    fi

    $cmd_make install &&

    cp -d \
       "$cfg_dir_toolchain/$cfg_target_canonical/$libdir"/libgcc_s.so* \
       "$cfg_dir_toolchain_sysroot/lib" &&
    cp -d \
       "$cfg_dir_toolchain/$cfg_target_canonical/$libdir"/libstdc++.so* \
       "$cfg_dir_toolchain_sysroot/usr/lib"
}

target_install()
{
    $cmd_mkdir \
        "$cfg_dir_rootfs/usr/lib" &&

    for f in "$cfg_dir_toolchain/$cfg_target_canonical/lib/"{libgcc_s,libstdc++}.so*; do
        base="$(basename $f)"

        if [ $(echo "$base" | grep '\.py' 2> /dev/null) ]; then
            continue
        fi

        if [ -L "$f" ]; then
            cp -vd "$f" "$cfg_dir_rootfs/usr/lib/$base"
        elif [ -f "$f" ]; then
            $cmd_target_strip -v --strip-unneeded -o "$cfg_dir_rootfs/usr/lib/$base" "$f"
        fi
    done
}
