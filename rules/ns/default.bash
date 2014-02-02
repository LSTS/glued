version=\
(
    '2.34'
)

url=\
(
    "http://downloads.sourceforge.net/nsnam/ns-$version.tar.gz"
)

md5=\
(
    '5dbc3e0a5c240fe9a1c11bef9dd19ef7'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'qemu/host'
    'tcl/default'
    'tk/default'
    'otcl/default'
    'tclcl/default'
)

post_unpack()
{
    patches=$(ls "$cfg_package_spec_dir/patches/"*.patch)
    if [ -n "$patches" ]; then
        cat $patches | patch -p1
    fi
}

configure()
{
    prefix="/"

    "../ns-$version/configure" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --prefix="$prefix" \
        --with-tcl="$cfg_dir_toolchain_sysroot/usr" \
        --with-tk="$cfg_dir_toolchain_sysroot/usr" \
        --with-otcl="$cfg_dir_toolchain_sysroot/usr" \
        --with-tclcl="$cfg_dir_toolchain_sysroot/usr"

    sed 's/#define RANDOM_RETURN_TYPE int/#define RANDOM_RETURN_TYPE long int/g' "../ns-$version/autoconf.h" -i
    sed "s#./common/ptypes2tcl#qemu-arm -L ${cfg_dir_rootfs} ${cfg_dir_rootfs}/lib/ld-linux.so.3 ./common/ptypes2tcl#g" "../ns-$version/Makefile" -i
}

build()
{
    sed "s#\$(TCLSH)#qemu-arm -L ${cfg_dir_rootfs} ${cfg_dir_rootfs}/lib/ld-linux.so.3 ${cfg_dir_toolchain_sysroot}/usr/bin/tclsh#g" "../ns-$version/Makefile" -i

    sed "s#\$(TCL2C)#qemu-arm -L ${cfg_dir_rootfs} ${cfg_dir_rootfs}/lib/ld-linux.so.3 ${cfg_dir_toolchain_sysroot}/usr/bin/tcl2c++#g" "../ns-$version/Makefile" -i

    $cmd_make -j1
}

host_install()
{
    $cmd_mkdir \
        "$cfg_dir_toolchain_sysroot/ns2/bin" \
        "$cfg_dir_toolchain_sysroot/ns2/man/man1" &&


    $cmd_make \
        DESTDIR="$cfg_dir_toolchain_sysroot/ns2" \
        install

}

target_install()
{
    $cmd_mkdir \
	"${cfg_dir_rootfs}/usr/ns2/bin" &&

    $cmd_target_strip "${cfg_dir_toolchain_sysroot}/ns2/bin/ns" -o "${cfg_dir_rootfs}/usr/ns2/bin/ns"
}
