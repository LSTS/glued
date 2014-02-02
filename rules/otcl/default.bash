version=\
(
    '1.13'
)

url=\
(
    "http://downloads.sourceforge.net/otcl-tclcl/otcl-src-$version.tar.gz"
)

md5=\
(
    'f3e4864445429506397b720c7232e4c6'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'tcl/default'
    'xorg-libx11/default'
    'xorg-libxt/default'
)

configure()
{
    prefix="${cfg_dir_toolchain_sysroot}/usr"

    sed "s%/usr/unsupported%${prefix}%g" "../otcl-$version/conf/configure.in.x11" -i

    export AR="$cmd_target_ar"

    cd ../otcl-$version && autoconf && cd - &&
    ../otcl-$version/configure \
        --prefix=$prefix \
        --target=$cfg_target_canonical \
        --host=$cfg_target_canonical \
        --build=$cfg_host_canonical \
        --with-tcl=${cfg_dir_toolchain_sysroot}/usr \
        --with-tk=${cfg_dir_toolchain_sysroot}/usr
}

build()
{
    $cmd_make -j1 \
        SHLIB_LD="$cmd_target_ld -shared"
}

host_install()
{
    $cmd_make \
        SHLIB_LD="$cmd_target_ld -shared" \
        INST_OTCLSH="${cfg_dir_toolchain_sysroot}/usr/bin" \
        INST_OWISH="${cfg_dir_toolchain_sysroot}/usr/bin" \
        INST_OLIB="${cfg_dir_toolchain_sysroot}/usr/lib" \
        INST_OLIBSH="${cfg_dir_toolchain_sysroot}/usr/lib" \
        INST_OINC="${cfg_dir_toolchain_sysroot}/usr/include" \
        install
}

target_install()
{
    $cmd_target_strip libotcl.so -o $cfg_dir_rootfs/lib/libotcl.so
}
