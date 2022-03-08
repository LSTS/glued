version=\
(
  '2_6_2'
)

requires=\
(
  'ncurses'
  'zlib'
  'bzip2'
  'readline'
  'python/default'
  'omniorb/default'
)

url=\
(
  "http://freefr.dl.sourceforge.net/project/omnievents/omniEvents%20-%20stable/omniEvents%202.6.2/omniEvents-${version}-src.tar.gz"
)

md5=\
(
  "2087d0f6b7e89da22697c8854a9c8ad0"
)

post_unpack()
{
  patches=$(ls "$pkg_dir"/patches-${version}/*.patch)
  if [ -n "$patches" ]; then
#    echo " cat $patches | patch -p1 "
    cat $patches | patch -p1
  fi
}

configure()
{
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
  # It does not support multi jobs because some task are ling to IDL generated files.
  $cmd_make_single
}

host_install()
{
  $cmd_make_single install
}

target_install()
{
  # Log:
  $cmd_mkdir "${cfg_dir_rootfs}/var/lib/omniEvents/"
  $cmd_cp    "${pkg_dir}/fs/etc/rc.d/omniEvents"    "$cfg_dir_rootfs/etc/rc.d/omniEvents"
  $cmd_cp    "${pkg_dir}/fs/etc/omniorb-eventservice"    "${cfg_dir_rootfs}/etc/"

  # Binaries:
  $cmd_cp "${cfg_dir_toolchain_sysroot}/usr/lib/lib"*"omniEvents"* "${cfg_dir_rootfs}/usr/lib"
  $cmd_cp "${cfg_dir_toolchain_sysroot}/usr/bin/eventc" "${cfg_dir_rootfs}/usr/bin"
  $cmd_cp "${cfg_dir_toolchain_sysroot}/usr/bin/eventf" "${cfg_dir_rootfs}/usr/bin"
  $cmd_cp "${cfg_dir_toolchain_sysroot}/usr/bin/events" "${cfg_dir_rootfs}/usr/bin"
  $cmd_cp "${cfg_dir_toolchain_sysroot}/usr/bin/rmeventc" "${cfg_dir_rootfs}/usr/bin"
  $cmd_cp "src/omniEvents" "${cfg_dir_rootfs}/usr/bin"
}

