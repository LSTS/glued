version=\
(
    "8.4.19"
)

url=\
(
    "http://downloads.sourceforge.net/tcl/tk$version-src.tar.gz"
)

md5=\
(
    "9b998d0456d1b956eb9da610837a9c47"
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

requires=\
(
    'tcl/default'
    'xorg-libx11/default'
)

configure()
{
    dir_lib="${cfg_dir_toolchain_sysroot}/usr/lib"
    dir_inc="${cfg_dir_toolchain_sysroot}/usr/include"

    cat "${dir_lib}/tclConfig.sh" | \
        sed "s#-L/usr/lib#-L${dir_lib}#g" | \
        sed "s#-I/usr/include#-I${dir_inc}#g" > tclConfig.sh

    export ac_cv_func_strtod=yes
    export tcl_cv_strtod_buggy=1

    cd ../tk$version/unix && autoconf && cd - &&
    ../tk$version/unix/configure \
        --prefix="/usr" \
        --target=$cfg_target_canonical \
        --host=$cfg_target_canonical \
        --build=$cfg_host_canonical \
        --with-tcl=$PWD \
        --without-x
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
}

target_install()
{
    $cmd_target_strip "$cfg_dir_toolchain_sysroot/usr/lib/"libtk8.4.so -o $cfg_dir_rootfs/lib/libtk8.4.so #&&
}
