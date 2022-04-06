version=\
(
    "4.1.3"
)

url=\
(
    "http://download.zeromq.org/zeromq-$version.tar.gz"
)

md5=\
(
    "d0824317348cfb44b8692e19cc73dc3a"
)

configure()
{
    mkdir $cfg_dir_builds/$pkg/toolchain
    mkdir $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical
    mkdir $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot
    mkdir $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot/usr
    mkdir $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot/usr/lib
    export cfg_dir_output_toolchain_sysroot=$cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot

    ./configure \
        --prefix="${cfg_dir_output_toolchain_sysroot}/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --without-libsodium
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

  # Libs:
  for f in "$cfg_dir_output_toolchain_sysroot/usr/lib/"libzmq.*; do
    if [ -L "$f" ]; then
      $cmd_cp "$f" "$cfg_dir_output_rootfs/usr/lib"
    else
      $cmd_target_strip -v "$f" -o "$cfg_dir_output_rootfs/usr/lib/$(basename "$f")"
    fi
  done

  tar -czf ../zeromq-v$version.tar.gz ../rootfs ../toolchain
}
