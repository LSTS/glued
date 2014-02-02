version=\
(
    '4.1.4'
)

url=\
(
    "http://downloads.sourceforge.net/omniorb/omniORB-${version}.tar.gz"
)

md5=\
(
    '1f6070ff9b6339876976d61981eeaa6a'
)

requires=\
(
    'ncurses'
    'zlib'
    'bzip2'
    'readline'
    'python/default'
)

configure()
{
    cd ../omniORB-$version

    $cmd_make clean

    ./configure    \
        CC="$cmd_target_cc" \
        CXX="$cmd_target_cxx" \
        --includedir="${cfg_dir_toolchain_sysroot}/usr/include" \
        --prefix="${cfg_dir_toolchain_sysroot}/usr" \
        --build="${cfg_host_canonical}" \
        --host="${cfg_target_canonical}"
}

build()
{
    cd ../omniORB-$version

    # Build x86->ARM omnicpp:
    echo " Building omniidl cccp files: "
    $cmd_make CC="gcc" -C src/tool/omniidl/cxx/cccp

    # Build x86->ARM omniidl:
    echo " Building omniidl cxx: "
    $cmd_make CXX="g++" -C src/tool/omniidl/cxx

    # Build x86->ARM omkdepend:
    echo " Building omkdepend: "
    $cmd_make CC="gcc" -C src/tool/omkdepend

    echo " Building omniorb for target: "
    $cmd_make
}

host_install()
{
    cd ../omniORB-$version
    $cmd_make install
}

target_install()
{
    # Libs:
    for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libomni*.so*; do
        if [ -L "$f" ]; then
            $cmd_cp "$f" "$cfg_dir_rootfs/usr/lib"
        else
            $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
        fi
    done
    $cmd_cp "$cfg_dir_toolchain_sysroot/usr/lib/"libCOS* "$cfg_dir_rootfs/usr/lib"

    # Bins:
    $cmd_cp "$cfg_dir_toolchain_sysroot/usr/bin/catior"        "$cfg_dir_rootfs/usr/bin"
    $cmd_cp "$cfg_dir_toolchain_sysroot/usr/bin/convertior"    "$cfg_dir_rootfs/usr/bin"
    $cmd_cp "$cfg_dir_toolchain_sysroot/usr/bin/genior"        "$cfg_dir_rootfs/usr/bin"
    $cmd_cp "$cfg_dir_toolchain_sysroot/usr/bin/nameclt"       "$cfg_dir_rootfs/usr/bin"
    $cmd_cp "$cfg_dir_toolchain_sysroot/usr/bin/omniidl"       "$cfg_dir_rootfs/usr/bin"
    $cmd_cp "$cfg_dir_toolchain_sysroot/usr/bin/omniidlrun.py" "$cfg_dir_rootfs/usr/bin"
    $cmd_cp "$cfg_dir_toolchain_sysroot/usr/bin/omniMapper"    "$cfg_dir_rootfs/usr/bin"
    $cmd_cp "$cfg_dir_toolchain_sysroot/usr/bin/omniNames"     "$cfg_dir_rootfs/usr/bin"
    $cmd_cp "$cfg_dir_toolchain_sysroot/usr/bin/nameclt"       "$cfg_dir_rootfs/usr/bin"
    $cmd_cp "$cfg_dir_toolchain_sysroot/usr/bin/nameclt"       "$cfg_dir_rootfs/usr/bin"
    $cmd_cp "$cfg_dir_toolchain_sysroot/usr/bin/catior"        "$cfg_dir_rootfs/usr/bin"

    # Specific configuration:
    $cmd_cp "${cfg_package_spec_dir}/fs/etc/rc.d/omninames"    "$cfg_dir_rootfs/etc/rc.d/omninames"
    $cmd_cp "${cfg_package_spec_dir}/fs/etc/omniORB.cfg"       "$cfg_dir_rootfs/etc/omniORB.cfg"

    # Log:
    $cmd_mkdir "${cfg_dir_rootfs}/var/omninames/"
}
