version=\
(
   "git"
)

url=\
(
  "http://localhost/rtl-sdr-${version}.tar.bz2"
)

md5=\
(
    '74fb22d71d08a8cb6dd6948a80cbe45f'
)

requires=\
(
    'libusb'
    'libusb-compat'
)

configure()
{
    mkdir build && cd build
    cmake								\
        -DCMAKE_FIND_ROOT_PATH="${cfg_dir_toolchain_sysroot}/usr"	\
	-DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM="NEVER"			\
	-DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY="ONLY_CMAKE_FIND_ROOT_PATH"	\
	-DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE="ONLY_CMAKE_FIND_ROOT_PATH"	\
	-DCMAKE_C_COMPILER="${cmd_target_cc}"				\
	-DCMAKE_CXX_COMPILER="${cmd_target_cxx}"			\
        -DCMAKE_INSTALL_PREFIX="$cfg_dir_toolchain_sysroot/usr"		\
	-DCMAKE_C_FLAGS="${cfg_target_gcc_flags}"			\
        ..
}

build()
{
    cd build
    $cmd_make
}

host_install()
{
    cd build
    $cmd_make install
}

target_install()
{
  # Libs:
  for f in "$cfg_dir_toolchain_sysroot/usr/lib/"librtlsdr*.so*; do
    if [ -L "$f" ]; then
      $cmd_cp "$f" "$cfg_dir_rootfs/usr/lib"
    else
      $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
    fi
  done

  # Bins:
  for f in "$cfg_dir_toolchain_sysroot/usr/bin/"rtl_*; do
    if [ -L "$f" ]; then
      $cmd_cp "$f" "$cfg_dir_rootfs/usr/bin"
    else
      $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/bin/$(basename "$f")"
    fi
  done



}
