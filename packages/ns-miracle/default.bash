version=\
(
    '1.0'
)

dei_version=\
(
    '1.1.4'
)

ns_version=\
(
    '2.34'
)

url=\
(
    "http://www.lsts.pt/glued/ns-miracle-$version.tar.gz"
)

md5=\
(
    '860072ac58b2d1274da46d02b5608229'
)

requires=\
(
    'ns/default'
    'dei80211mr/default'
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
	cd ../ns-miracle-$version/trunk/main/
    prefix="/ns2_lib"
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
/usr/bin/aclocal -I m4 --force && /usr/bin/libtoolize --force && /usr/bin/automake --foreign --add-missing && /usr/bin/autoconf

    sed "s#@TCL2CPP@#qemu-arm -L ${cfg_dir_rootfs} ${cfg_dir_rootfs}/lib/ld-linux.so.3 ${cfg_dir_toolchain_sysroot}/usr/bin/tcl2c++#g" "./m4/Makefile.in" -i

    sed "s#@TCL2CPP@#qemu-arm -L ${cfg_dir_rootfs} ${cfg_dir_rootfs}/lib/ld-linux.so.3 ${cfg_dir_toolchain_sysroot}/usr/bin/tcl2c++#g" "./Makefile.in" -i


    "./configure" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --prefix="$prefix" \
	--disable-static \
	--enable-shared \
	--with-ns-allinone=${cfg_dir_builds}/ns/ \
	--with-dei80211mr=${cfg_dir_builds}/dei80211mr/dei80211mr-$dei_version
}

build()
{
	cd ../ns-miracle-$version/trunk/main/

    $cmd_make -j1 \
       TCL2CPP="qemu-arm -L ${cfg_dir_rootfs} ${cfg_dir_rootfs}/lib/ld-linux.so.3 ${cfg_dir_toolchain_sysroot}/usr/bin/tcl2c++"
}

host_install()
{
	cd ../ns-miracle-$version/trunk/main/
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
