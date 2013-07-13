version=\
(
    "6.25"
)

url=\
(
    "http://nmap.org/dist/nmap-$version.tar.bz2"
)

md5=\
(
    "fcc80f94ff3adcb11eedf91092ea6f5e"
)

# It require LUA 5.0.2 .
requires=\
(
  "lua/default"
  "libpcap/default"
)

configure()
{
  ./configure                                     \
     --prefix="${cfg_dir_toolchain_sysroot}/usr"  \
     --target="$cfg_target_canonical"             \
     --host="$cfg_target_canonical"               \
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
  # Bins: 
  $cmd_target_strip -v "$cfg_dir_toolchain_sysroot/usr/bin/nmap"   -o "$cfg_dir_rootfs/usr/bin/nmap"
  $cmd_target_strip -v "$cfg_dir_toolchain_sysroot/usr/bin/ncat"   -o "$cfg_dir_rootfs/usr/bin/ncat"
  $cmd_target_strip -v "$cfg_dir_toolchain_sysroot/usr/bin/nping"  -o "$cfg_dir_rootfs/usr/bin/nping"
  $cmd_cp "$cfg_dir_toolchain_sysroot/usr/bin/ndiff"  "$cfg_dir_rootfs/usr/bin/"
  $cmd_cp "$cfg_dir_toolchain_sysroot/usr/bin/zenmap"  "$cfg_dir_rootfs/usr/bin/"
  $cmd_cp "$cfg_dir_toolchain_sysroot/usr/bin/nmapfe" "$cfg_dir_rootfs/usr/bin/"
  sed -i "s,${cfg_dir_toolchain_sysroot},,g" $cfg_dir_rootfs/usr/bin/nmapfe

  # Copy scripts:
  $cmd_cp "$cfg_dir_toolchain_sysroot/usr/share/nmap" 		"$cfg_dir_rootfs/usr/share/"
}


