version=\
(
  "3.2.3"
)

url=\
(
  "http://downloads.sourceforge.net/project/witty/wt/${version}/wt-${version}.tar.gz"
)

md5=\
(
  '58922ba5d68104880adbe2e022132fb5'
)

requires=\
(
  'cmake/host'
  'boost/default'
)

configure()
{
  mkdir build
  cd build
  cmake \
    -DCMAKE_FIND_ROOT_PATH="${cfg_dir_toolchain_sysroot}/usr"     \
    -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY_CMAKE_FIND_ROOT_PATH \
    -DCMAKE_C_COMPILER="${cmd_target_cc}"                         \
    -DCMAKE_CXX_COMPILER="${cmd_target_cxx}"                      \
    -DCMAKE_INSTALL_PREFIX="${cfg_dir_toolchain_sysroot}/usr"     \
    -DCONFIGDIR="${cfg_dir_toolchain_sysroot}/etc"                \
    -DENABLE_SSL=off       \
    -DMULTI_THREADED=on    \
    -DENABLE_POSTGRES=off  \
    -DENABLE_SQLITE=off    \
    -DENABLE_FIREBIRD=off  \
    ..

    sed -i "s,${cfg_dir_toolchain_sysroot},,g" Wt/WConfig.h
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
  for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libwt*; do
    if [ -L "$f" ]; then
      $cmd_cp "$f" "$cfg_dir_rootfs/usr/lib"
    else
      $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
    fi
  done

  # Configs:
  $cmd_cp $cfg_dir_toolchain_sysroot/etc/wt* $cfg_dir_rootfs/etc/
  # wthttpd might be missing ...
}

