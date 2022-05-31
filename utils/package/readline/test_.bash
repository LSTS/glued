version=\
(
    '8.0'
)

revision=\
(
    '1'
)

url=\
(
    "ftp://ftp.gnu.org/gnu/readline/readline-$version.tar.gz"
)

md5=\
(
    '7e6c1f16aee3244a69aba6e438295ca3'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

post_unpack()
{
    patches=$(ls "$pkg_dir/patches/"*.patch)
    if [ -n "$patches" ]; then
        cat $patches | patch -p0
    fi
}

configure()
{
    mkdir $cfg_dir_builds/$pkg/toolchain
    mkdir $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical
    mkdir $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot
    mkdir $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot/usr
    mkdir $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot/usr/lib
    export cfg_dir_output_toolchain_sysroot=$cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot

    "../readline-$version/configure" \
        --prefix="$cfg_dir_output_toolchain_sysroot/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical"
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}

target_install()
{
  mkdir $cfg_dir_builds/$pkg/rootfs
  mkdir $cfg_dir_builds/$pkg/rootfs/usr
  mkdir $cfg_dir_builds/$pkg/rootfs/usr/lib
  export cfg_dir_output_rootfs=$cfg_dir_builds/$pkg/rootfs

    for lib in history readline; do
        install "$cfg_dir_output_toolchain_sysroot/usr/lib/lib$lib.so"* "$cfg_dir_output_rootfs/usr/lib"
        $cmd_target_strip --strip-unneeded "$cfg_dir_output_rootfs/usr/lib/lib$lib.so"*
    done

  tar -czf ../readline-v$version.tar.gz ../rootfs ../toolchain
}
