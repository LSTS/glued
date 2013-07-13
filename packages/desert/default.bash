version=\
(
    '1.0'
)

ns_version=\
(
    '2.34'
)

url=\
(
    "http://www.lsts.pt/glued/desert-$version.tar.gz"
)

md5=\
(
    '5b83d1d6e5390a44f1dc0c5a3794581c'
)

requires=\
(
    'ns-miracle/default'
)

post_unpack()
{
    patches=$(ls "$cfg_package_spec_dir/patches/"*.patch)
    if [ -n "$patches" ]; then
        cat $patches | patch -p0
    fi
}

configure()
{
    find . -name "*.o" -exec rm {} \;
    /usr/bin/aclocal -I m4 --force && /usr/bin/libtoolize --force && /usr/bin/automake --foreign --add-missing && /usr/bin/autoconf

    prefix="/DESERT_lib"

    sed "s#@TCL2CPP@#qemu-arm -L ${cfg_dir_rootfs} ${cfg_dir_rootfs}/lib/ld-linux.so.3 ${cfg_dir_toolchain_sysroot}/usr/bin/tcl2c++#g" "./m4/Makefile.in" -i
    sed "s#@TCL2CPP@#qemu-arm -L ${cfg_dir_rootfs} ${cfg_dir_rootfs}/lib/ld-linux.so.3 ${cfg_dir_toolchain_sysroot}/usr/bin/tcl2c++#g" "./Makefile.in" -i

    "./configure" \
                --target="$cfg_target_canonical"                    \
                --host="$cfg_target_canonical"                      \
                --build="$cfg_host_canonical"                       \
                --with-ns-allinone=${cfg_dir_builds}/ns/            \
                --with-nsmiracle=${cfg_dir_builds}/ns-miracle/ns-miracle-1.0/trunk/main/      \
                --prefix="$prefix"

}

build()
{
    $cmd_make -j1 \
       TCL2CPP="qemu-arm -L ${cfg_dir_rootfs} ${cfg_dir_rootfs}/lib/ld-linux.so.3 ${cfg_dir_toolchain_sysroot}/usr/bin/tcl2c++"
}

host_install()
{
    $cmd_mkdir \
    "$cfg_dir_toolchain_sysroot/ns2/DESERT_lib/lib" &&

    $cmd_make \
        DESTDIR="$cfg_dir_toolchain_sysroot/ns2/" \
        install

}

target_install()
{
    cp -r "${cfg_dir_toolchain_sysroot}/ns2/DESERT_lib/lib" "${cfg_dir_rootfs}/usr/ns2/DESERT/"

    for f in "$cfg_dir_toolchain_sysroot/ns2/DESERT_lib/lib/"lib*.so.0.0.0; do
        $cmd_target_strip "$f" -o ${cfg_dir_rootfs}/usr/ns2/DESERT/"$(basename "$f")"
    done

}
