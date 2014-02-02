version=\
(
    '5.45'
)

url=\
(
    "http://downloads.sourceforge.net/expect/expect${version}.tar.gz"
)

md5=\
(
    '44e1a4f4c877e9ddc5a542dfa7ecc92b'
)

requires=\
(
    'tcl/default'
)

post_unpack()
{
    cd ../expect${version}
    patches=$(ls "$cfg_package_spec_dir/patches/"*.patch)
    if [ -n "$patches" ]; then
        cat $patches | patch -p1
    fi
    "${cfg_dir_toolchain}"/bin/autoreconf
}

configure()
{
    cd ../expect${version}
    ./configure \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
	--exec-prefix="$cfg_dir_toolchain_sysroot/usr" \
        --disable-static \
        --enable-shared \
        --target=$cfg_target_canonical \
        --host=$cfg_target_canonical \
        --build=$cfg_host_canonical \
	--with-tcl="${cfg_dir_toolchain_sysroot}/usr/lib" \
        --with-tclinclude="${cfg_dir_toolchain_sysroot}/usr/include" \
        --enable-threads \
        --enable-shared  \
        --disable-rpath
}

build()
{
    cd ../expect${version}
    $cmd_make
}

host_install()
{
    cd ../expect${version}
    # TODO create tclsh for the host toolchain
    #    sed -i -e '/TCLSH_PROG/s,=.*,= '"${cfg_dir_toolchain}"'/bin/tclsh,' Makefile
    sed -i -e '/TCLSH_PROG/s/=.*/= tclsh/' Makefile
    $cmd_make install
}

target_install()
{

    for f in "$cfg_dir_toolchain_sysroot/usr/bin/"expect*; do
        $cmd_target_strip "$f" -o $cfg_dir_rootfs/usr/bin/"$(basename "$f")"
    done
    $cmd_target_strip "$cfg_dir_toolchain_sysroot/usr/lib/expect${version}"/libexpect${version}.so -o $cfg_dir_rootfs/lib/libexpect${version}.so
}
