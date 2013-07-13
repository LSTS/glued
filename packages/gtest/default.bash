version=\
(
  "1.6.0"
)

url=\
(
  "http://googletest.googlecode.com/files/gtest-${version}.zip"
)

md5=\
(
  "4577b49f2973c90bf9ba69aa8166b786"
)

configure()
{
    ./configure \
        --prefix="${cfg_dir_toolchain_sysroot}/usr" \
        --target="$cfg_target_canonical"            \
        --host="$cfg_target_canonical"              \
        --build="$cfg_host_canonical"               \
        --with-gnu-ld
}

build()
{
  $cmd_make
}

host_install()
{
  $cmd_cp "lib/.libs/libgtest"* "$cfg_dir_toolchain_sysroot/usr/lib/"
  $cmd_cp "include/gtest/"      "$cfg_dir_toolchain_sysroot/usr/include/"
}


