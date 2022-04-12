version=\
(
    '0.2.5'
)

url=\
(
    "http://downloads.sourceforge.net/libtirpc/$version/libtirpc-$version.tar.bz2"
)

md5=\
(
    '8cd41a5ef5a9b50d0fb6abb98af15368'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
    mkdir -p $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot/usr
    export cfg_dir_output_toolchain_sysroot=$cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot

    "../libtirpc-$version/configure" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --prefix="$cfg_dir_output_toolchain_sysroot/usr" \
        --disable-gssapi \
        --disable-ipv6 \
        --disable-static \
        --enable-shared
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
    mkdir -p $cfg_dir_builds/$pkg/rootfs/usr/lib
    export cfg_dir_output_rootfs=$cfg_dir_builds/$pkg/rootfs

    $cmd_mkdir "$cfg_dir_output_rootfs/etc"
    $cmd_cp "doc/netconfig" "$cfg_dir_output_rootfs/etc/netconfig"

    for f in "$cfg_dir_output_toolchain_sysroot/usr/lib/"libtirpc*so*; do
        if [ -L "$f" ]; then
            cp -vd "$f" "$cfg_dir_output_rootfs/usr/lib"
        else
            $cmd_target_strip -v "$f" -o "$cfg_dir_output_rootfs/usr/lib/$(basename "$f")"
        fi
    done

    tar -czf ../libtirpc-v$version.tar.gz ../rootfs ../toolchain
}
