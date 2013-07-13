version=\
(
    '1.1.4'
)

ns_version=\
(
    '2.34'
)

url=\
(
    "http://www.lsts.pt/glued/dei80211mr-$version.tar.gz"
)

md5=\
(
    '8ad1adcd02fc41933d6528c093e1c3d9'
)

requires=\
(
    'ns/default'
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
    prefix="/ns2_lib"

cd ../dei80211mr-$version/

make distclean
rm -fr autom4te.cache/
rm config.*
rm missing
rm Makefile.in
rm install-sh
rm depcomp
rm configure
rm ltmain.sh
rm m4/libtool*
rm m4/Makefile
rm m4/Makefile.in
rm aclocal.m4
rm m4/lt*

find . -name "*.o" -exec rm {} \;

cd -

/usr/bin/aclocal -I m4 --force && /usr/bin/libtoolize --force && /usr/bin/automake --foreign --add-missing && /usr/bin/autoconf

    sed "s#@TCL2CPP@#qemu-arm -L ${cfg_dir_rootfs} ${cfg_dir_rootfs}/lib/ld-linux.so.3 ${cfg_dir_toolchain_sysroot}/usr/bin/tcl2c++#g" "./m4/Makefile.in" -i

    sed "s#@TCL2CPP@#qemu-arm -L ${cfg_dir_rootfs} ${cfg_dir_rootfs}/lib/ld-linux.so.3 ${cfg_dir_toolchain_sysroot}/usr/bin/tcl2c++#g" "./Makefile.in" -i

    sed "s#@TCL2CPP@#qemu-arm -L ${cfg_dir_rootfs} ${cfg_dir_rootfs}/lib/ld-linux.so.3 ${cfg_dir_toolchain_sysroot}/usr/bin/tcl2c++#g" "./src/Makefile.in" -i

    "../dei80211mr-$version/configure" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --prefix="$prefix" \
	--disable-static \
	--enable-shared \
	--with-ns-allinone=${cfg_dir_builds}/ns/ \
	--x-includes=no --x-libraries=no
}

build()
{

    $cmd_make -j1
}

host_install()
{
    $cmd_mkdir \
        "$cfg_dir_toolchain_sysroot/ns2/ns2_lib/lib" \
        "$cfg_dir_toolchain_sysroot/ns2/ns2_lib/share" &&

    $cmd_make \
        DESTDIR="$cfg_dir_toolchain_sysroot/ns2" \
        install

}

target_install()
{
    $cmd_mkdir \
	"${cfg_dir_rootfs}/usr/ns2/lib/"

    for f in "$cfg_dir_toolchain_sysroot/ns2/ns2_lib/lib/"lib*.so*; do
        $cmd_target_strip "$f" -o ${cfg_dir_rootfs}/usr/ns2/lib/"$(basename "$f")"
    done
}
