version=\
(
    '8.4.19'
)

url=\
(
    "http://downloads.sourceforge.net/tcl/tcl$version-src.tar.gz"
)

md5=\
(
    'ade2c033a7b545ee108f3fdfeb629fcf'
)

configure()
{
    export ac_cv_func_strtod=yes
    export tcl_cv_strtod_buggy=1

    cd ../tcl$version/unix && autoconf && cd - &&
    ../tcl$version/unix/configure \
        --prefix="/usr" \
        --target=$cfg_target_canonical \
        --host=$cfg_target_canonical \
        --build=$cfg_host_canonical \
        --enable-threads \
        --with-zlib="$cfg_dir_toolchain"
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make \
        DESTDIR="$cfg_dir_toolchain_sysroot" \
        install

    cp ../tcl$version/generic/tclInt.h "${cfg_dir_toolchain_sysroot}/usr/include"
    cp ../tcl$version/generic/tclIntDecls.h "${cfg_dir_toolchain_sysroot}/usr/include"

    ln -fs tclsh8.4 "$cfg_dir_toolchain_sysroot/usr/bin/tclsh"
}

target_install()
{
    for f in "$cfg_dir_toolchain_sysroot/usr/bin/"tclsh*; do
        $cmd_target_strip "$f" -o $cfg_dir_rootfs/usr/bin/"$(basename "$f")"
    done
    $cmd_target_strip "$cfg_dir_toolchain_sysroot/usr/lib/"libtcl8.4.so -o $cfg_dir_rootfs/lib/libtcl8.4.so &&
    tar -C "$cfg_dir_toolchain_sysroot"/usr/lib -c -f - tcl8.4 | tar -C "$cfg_dir_rootfs/usr/lib" -x -v -f -
}
