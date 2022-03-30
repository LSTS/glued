source $pkg_common


configure()
{
    sources_dir=${PWD}
    ${cmd_cp} Makefile Makefile-libbz2_so words* "$pkg_build_dir"
    cd "$pkg_build_dir" &&
    sed -i 's!-c \(.*\)*\.c$!-c '${sources_dir}'/\1.c!;s!: \(.*\)\.c$!: '${sources_dir}'/\1.c!;s!shared bzip2.c !shared  '${sources_dir}'/bzip2.c !' Makefile Makefile-libbz2_so
}


build()
{
    sources_dir=${PWD}
    cd "$pkg_build_dir"
    export CFLAGS="${CFLAGS} ${cfg_target_gcc_flags} -fPIC"

    # Static library.
    $cmd_make  \
	  LD=${cmd_target_ld} \
	  CC=${cmd_target_cc} \
	  AR=${cmd_target_ar} \
	  RANLIB=${cmd_target_ranlib} \
    libbz2.a &&

# Shared library.
    $cmd_make \
	  LD=${cmd_target_ld} \
	  CC=${cmd_target_cc} \
	  AR=${cmd_target_ar} \
	  RANLIB=${cmd_target_ranlib} \
        -f Makefile-libbz2_so &&
    ln -fs libbz2.so.$version libbz2.so.1
}

host_install()
{
    mkdir $cfg_dir_builds/$pkg/toolchain
    mkdir $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical
    mkdir $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot
    mkdir $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot/usr
    mkdir $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot/usr/lib
    mkdir $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot/usr/include
    export cfg_dir_output_toolchain_sysroot=$cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot

    cp bzlib.h "${cfg_dir_output_toolchain_sysroot}/usr/include" &&
    chmod a+r "${cfg_dir_output_toolchain_sysroot}/usr/include/bzlib.h" &&
    cd "$pkg_build_dir" &&
    cp libbz2.a "${cfg_dir_output_toolchain_sysroot}/usr/lib" &&
    chmod a+r "${cfg_dir_output_toolchain_sysroot}/usr/lib/libbz2.a" &&
    cp -d libbz2.so* "${cfg_dir_output_toolchain_sysroot}/usr/lib" &&
    chmod a+rx "${cfg_dir_output_toolchain_sysroot}/usr/lib/libbz2.so"*
}

target_install()
{
    mkdir $cfg_dir_builds/$pkg/rootfs
    mkdir $cfg_dir_builds/$pkg/rootfs/usr
    mkdir $cfg_dir_builds/$pkg/rootfs/usr/lib
    export cfg_dir_output_rootfs=$cfg_dir_builds/$pkg/rootfs/usr

    cd "$pkg_build_dir" &&
    for f in "${cfg_dir_output_toolchain_sysroot}/usr/lib/libbz2.so"* ; do
        dst="$cfg_dir_output_rootfs/lib/$(basename "$f")"
        cp -v -d "$f" "$dst" &&
        $cmd_target_strip "$dst"
    done

    chmod a+x $cfg_dir_output_rootfs/lib/libbz2.so*

    tar -czf ../bzip2-v$version.tar.gz ../rootfs ../toolchain
}
