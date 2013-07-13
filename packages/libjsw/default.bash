version=\
(
  "1.5.8"
)

url=\
(
  "http://wolfsinger.com/~wolfpack/packages/libjsw-${version}.tar.bz2"
)

md5=\
(
  "1158f770c3aa82587fd70e6bd3c840df"
)

configure()
{
  # Prefix:
  sed "s#/usr#${cfg_dir_toolchain_sysroot}/usr#g" "libjsw/Makefile" -i
  # gcc
  sed "s#cc#${cmd_target_cc}#g"                   "libjsw/Makefile" -i
  # gxx
  sed "s#c++#${cmd_target_cxx}#g"                 "libjsw/Makefile" -i
  # ldconfig
  sed "s#ldconfig#${cmd_target_ld}#g"                 "libjsw/Makefile" -i
}

build()
{
  cd libjsw
  $cmd_make
}

host_install()
{
  cd libjsw
  $cmd_cp libjsw* "${cfg_dir_toolchain_sysroot}/usr/lib"
  $cmd_cp ../include/jsw.h   "${cfg_dir_toolchain_sysroot}/usr/include"
}

target_install()
{
  cd libjsw
  $cmd_cp libjsw* "$cfg_dir_rootfs/usr/lib"
}
