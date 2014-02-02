version=\
(
  "5.3.0"
)

url=\
(
  "http://collectd.org/files/collectd-$version.tar.bz2"
)

md5=\
(
  "1f0eb7b27ada94b22ed881daf788958b"
)

requires=\
(
  "libpcap/default"
  "libxml2/default"
  "curl/default"
  "perl/default"
  "ntp/default"
  "liboping/default"
  "rrdtool/default"
)

configure()
{
  ./configure \
     LIBGCRYPT_CONFIG="$cfg_dir_toolchain_sysroot/usr/bin/libgcrypt-config" \
     with_perl_bindings=no                      \
    --prefix="${cfg_dir_toolchain_sysroot}/usr" \
    --target="$cfg_target_canonical"            \
    --host="$cfg_target_canonical"              \
    --build="$cfg_host_canonical"               \
    --with-fp-layout="nothing"
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
  # Libs: /usr/lib/
  for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libcollectd*.so*; do
    if [ -L "$f" ]; then
      $cmd_cp "$f" "$cfg_dir_rootfs/usr/lib"
    else
      $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
    fi
  done

  # Libs in collectd folder: /usr/lib/collectd
  $cmd_mkdir "$cfg_dir_rootfs/usr/lib/collectd"
  for f in "$cfg_dir_toolchain_sysroot/usr/lib/collectd/"*.so*; do
    if [ -L "$f" ]; then
      $cmd_cp "$f" "$cfg_dir_rootfs/usr/lib/collectd"
    else
      $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/collectd/$(basename "$f")"
    fi
  done

  # /usr/bin: 
  for f in "$cfg_dir_toolchain_sysroot/usr/bin/"collectd*; do
    if [ -L "$f" ]; then
      $cmd_cp "$f" "$cfg_dir_rootfs/usr/bin"
    else
      $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/bin/$(basename "$f")"
    fi
  done

  # /usr/sbin: 
  for f in "$cfg_dir_toolchain_sysroot/usr/sbin/"collectd*; do
    if [ -L "$f" ]; then
      $cmd_cp "$f" "$cfg_dir_rootfs/usr/bin"
    else
      $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/bin/$(basename "$f")"
    fi
  done

  # Collectd:
  $cmd_mkdir "$cfg_dir_rootfs/usr/share/"
  $cmd_cp    "$cfg_dir_toolchain_sysroot/usr/share/collectd/" "$cfg_dir_rootfs/usr/share/"
  $cmd_cp    "${cfg_package_spec_dir}/fs/etc/rc.d/collectd"   "$cfg_dir_rootfs/etc/rc.d/"

  # Configuration:
  echo "# Client
BaseDir   \"/opt/lsts/\"
PluginDir \"/usr/lib/collectd/\"
TypesDB   \"/usr/share/collectd/types.db\"

# Interface:
Interval    60
ReadThreads 10
Hostname \"${cfg_hostname}\"

# Modules:
LoadPlugin \"cpu\"
LoadPlugin \"memory\"
LoadPlugin \"df\"
LoadPlugin \"disk\"
LoadPlugin \"load\"
LoadPlugin \"processes\"
LoadPlugin \"syslog\"
LoadPlugin \"tcpconns\"

# Interface:
LoadPlugin interface
<Plugin interface>
    Interface \"eth0\"
</Plugin>

# Client
LoadPlugin \"network\"
<Plugin \"network\">
  Server \"192.168.0.60\"
</Plugin>

# Logfile:
LoadPlugin \"logfile\"
<Plugin \"logfile\">
  LogLevel \"info\"
  File \"/opt/lsts/log/collectd/collectd_client.log\"
  Timestamp true
</Plugin>
" > "$cfg_dir_rootfs/etc/collectd_client.cfg"
}

