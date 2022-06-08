version=\
(
    '1.0.2e'
)

url=\
(
    "http://www.openssl.org/source/openssl-$version.tar.gz"
)

md5=\
(
    '5262bfa25b60ed9de9f28d5d52d77fc5'
)

requires=\
(
    'zlib/default'
)

configure()
{
    mkdir -p $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot/usr
    export cfg_dir_output_toolchain_sysroot=$cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot

    ./Configure linux-generic32 --cross-compile-prefix="$cfg_target_canonical-" \
                --prefix="$cfg_dir_output_toolchain_sysroot/usr" \
                --openssldir="$cfg_dir_output_toolchain_sysroot/usr" \
                shared
}

build()
{
    $cmd_make depend &&
    $cmd_make all
}

host_install()
{
    $cmd_make -j1 install
}

target_install()
{
    mkdir -p $cfg_dir_builds/$pkg/rootfs/usr/lib
    export cfg_dir_output_rootfs=$cfg_dir_builds/$pkg/rootfs/usr

    for f in $cfg_dir_output_toolchain_sysroot/usr/lib/{libcrypto.so*,libssl.so*}; do
        name="$cfg_dir_output_rootfs/lib/$(basename $f)"
        if [ -f "$f" ]; then
            $cmd_target_strip "$f" -o "$name"
        else
            $cmd_cp "$f" "$name"
        fi
    done
 
    tar -czf ../openssl-v$version.tar.gz ../rootfs ../toolchain
}
