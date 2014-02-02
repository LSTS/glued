version=\
(
    "5.7.2"
)

url=\
(
    "http://downloads.sourceforge.net/project/net-snmp/net-snmp/$version/net-snmp-$version.tar.gz"
)

md5=\
(
    "5bddd02e2f82b62daa79f82717737a14"
)

configure()
{
#        --with-install-prefix="${cfg_dir_toolchain_sysroot}/usr" \
    ./configure                                                  \
        --prefix="${cfg_dir_toolchain_sysroot}/usr"              \
        --target="$cfg_target_canonical"                         \
        --host="$cfg_target_canonical"                           \
        --build="$cfg_host_canonical"                            \
        --with-default-snmp-version="3"                          \
        --with-sys-contact="root@localhost"                      \
        --with-sys-location="Mobile"                             \
        --with-logfile="/opt/lsts/log/snmpd.log"                 \
        --with-persistent-directory="/var/net-snmp"              \
        --disable-embedded-perl                                  \
        --with-perl-modules=no                                   \
        --with-gnu-ld
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
  # Libs: 
  for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libnetsnmp*.so*; do
    if [ -L "$f" ]; then
      $cmd_cp "$f" "$cfg_dir_rootfs/usr/lib"
    else
      $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
    fi
  done

  # Bin: 
  for f in "$cfg_dir_toolchain_sysroot/usr/bin/"snmp*; do
    if [ -L "$f" ]; then
      $cmd_cp "$f" "$cfg_dir_rootfs/usr/bin"
    else
      $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/bin/$(basename "$f")"
    fi
  done
}

