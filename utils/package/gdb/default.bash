source $pkg_common

requires=\
(
    'readline/rpi4'
    'ncurses/rpi4'
)

configure()
{
    mkdir $cfg_dir_builds/$pkg/toolchain
    mkdir $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical
    mkdir $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot
    mkdir $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot/usr
    mkdir $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot/usr/lib
    export cfg_dir_output_toolchain_sysroot=$cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot

    cd "$pkg_build_dir" &&
    CFLAGS=-I"$cfg_dir_toolchain_sysroot/usr/include" \
	  LDFLAGS=-L"$cfg_dir_toolchain_sysroot/usr/lib" \
        "../gdb-$version/configure" \
        --prefix="$cfg_dir_output_toolchain_sysroot/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --with-sysroot="$cfg_dir_toolchain_sysroot" \
        --disable-nls \
        --with-curses \
        --with-system-readline
}

build()
{
    $cmd_make -C "$pkg_build_dir"
}

host_install()
{
    $cmd_make -C "$pkg_build_dir" install
}

target_install()
{
    mkdir $cfg_dir_builds/$pkg/rootfs
    mkdir $cfg_dir_builds/$pkg/rootfs/usr
    mkdir $cfg_dir_builds/$pkg/rootfs/usr/bin
    export cfg_dir_output_rootfs=$cfg_dir_builds/$pkg/rootfs

    $cmd_target_strip \
        "$cfg_dir_output_toolchain_sysroot/usr/bin/gdb" \
        -o "$cfg_dir_output_rootfs/usr/bin/gdb" &&

    $cmd_target_strip \
        "$cfg_dir_output_toolchain_sysroot/usr/bin/gdbserver" \
        -o "$cfg_dir_output_rootfs/usr/bin/gdbserver"
    
    tar -czf ../gdb-v$version.tar.gz ../rootfs ../toolchain
}
