version=\
(
  "0.5.0"
)

url=\
(
  "http://yaml-cpp.googlecode.com/files/yaml-cpp-${version}.tar.gz"
)

md5=\
(
  "c6d96190434d5959d814c603f98512c6"
)

requires=\
(
  "cmake/host"
)

configure()
{
  $cmd_mkdir build
  cd build

  cmake \
    -DCMAKE_C_COMPILER="${cmd_target_cc}"                      \
    -DCMAKE_CXX_COMPILER="${cmd_target_cxx}"                   \
    -DCMAKE_FIND_ROOT_PATH="${cfg_dir_toolchain_sysroot}/usr"  \
    -DCMAKE_INSTALL_PREFIX="${cfg_dir_toolchain_sysroot}/usr"  \
    -DBUILD_SHARED_LIBS=ON \
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
  for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libyaml-cpp*.so*; do
    if [ -L "$f" ]; then
      cp -av "$f" "$cfg_dir_rootfs/usr/lib"
    else
      $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
    fi
  done
}


