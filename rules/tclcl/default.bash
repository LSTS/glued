version=\
(
    "1.19"
)

url=\
(
    "http://downloads.sourceforge.net/otcl-tclcl/tclcl-src-$version.tar.gz"
)

md5=\
(
    "023aefbd2e6d99ad96eb2cbe8acdbf4a"
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

post_unpack()
{
    patches=$(ls "$cfg_package_spec_dir"/patches/*.patch)
    if [ -n "$patches" ]; then
        cat $patches | patch -p1
    fi
}

configure()
{
    prefix="${cfg_dir_toolchain_sysroot}/usr"

    sed "s%/usr/unsupported%${prefix}%g" "../otcl-$version/conf/configure.in.x11" -i

    export AR="$cmd_target_ar"

    cd ../tclcl-$version && autoconf && cd - &&
    ../tclcl-$version/configure \
        --prefix=$prefix \
        --target=$cfg_target_canonical \
        --host=$cfg_target_canonical \
        --build=$cfg_host_canonical \
        --with-tcl=${cfg_dir_toolchain_sysroot}/usr \
        --with-tk=${cfg_dir_toolchain_sysroot}/usr \
        --with-otcl=${cfg_dir_toolchain_sysroot}/usr
}

build()
{
sed "s#\$(TCL2C) et#qemu-arm -L ${cfg_dir_rootfs} ${cfg_dir_rootfs}/lib/ld-linux.so.3 ./tcl2c++ et#g" "../tclcl-$version/Makefile" -i

    $cmd_make \
        SHLIB_LD="$cmd_target_ld -shared"
}

host_install()
{
    $cmd_make \
        DESTDIR="${cfg_dir_toolchain_sysroot}/usr" \
        install
}

target_install()
{
    cp ${cfg_dir_toolchain_sysroot}/usr/bin/tcl2c++ ${cfg_dir_rootfs}/usr/bin/
}
