version=\
(
  "1.0.1c"
)

url=\
(
  "http://www.openssl.org/source/openssl-$version.tar.gz"
)

md5=\
(
  "ae412727c8c15b67880aef7bd2999b2e"
)

requires=\
(
  'zlib/default'
)

configure()
{
  ./Configure \
    --prefix="${cfg_dir_toolchain_sysroot}/usr" \
    shared \
    dist
}

build()
{
  CC="${cmd_target_cc}"         \
  CXX="${cmd_target_cpp}"       \
  AR="${cmd_target_ar}"         \
  RANLIB="${cmd_target_ranlib}" \
  ARFLAGS="${cfg_target_ar_flags}" \
  $cmd_make build_libs
}

host_install()
{
# Can not use the install as it throws an error.
#  $cmd_make install
  $cmd_cp include/ ${cfg_dir_toolchain_sysroot}/usr
  $cmd_cp lib* ${cfg_dir_toolchain_sysroot}/usr/lib
}

target_install()
{
  $cmd_cp lib*so* ${cfg_dir_toolchain_sysroot}/usr/lib
  $cmd_cp lib*.a ${cfg_dir_toolchain_sysroot}/usr/lib
}

