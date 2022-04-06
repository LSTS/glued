source $pkg_common

requires=\
(
  'gnutls/default'
)

configure()
{
  ./configure					\
    --prefix="$cfg_dir_toolchain_sysroot/usr"	\
    --target="$cfg_target_canonical"		\
    --host="$cfg_target_canonical"		\
    --build="$cfg_host_canonical"		\
    --with-sysroot="$cfg_dir_toolchain_sysroot"
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
  $cmd_target_strip "$cfg_dir_toolchain_sysroot/usr/bin/wget" -o "$cfg_dir_rootfs/usr/bin/wget"
}
