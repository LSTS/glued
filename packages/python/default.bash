# Following indication from: http://randomsplat.com/id5-cross-compiling-python-for-embedded-linux.html
source $PKG_COMMON

requires=\
(
    'python/cross'
    'bzip2/default'
    'zlib/default'
)

configure()
{
  cd ../Python-$version
  echo "Configure is in $(pwd)"

  # We are patching the source as python needs python to compile python for our target:
  patch -p1 < "${cfg_package_spec_dir}/patches/Python-${version}-xcompile.patch"
  patch -p1 < "${cfg_package_spec_dir}/patches/001-Enable-zlib-bz2.patch"

  export CC="$cfg_target_canonical-gcc"
  export CXX="$cfg_target_canonical-g++"
  export AR="$cfg_target_canonical-ar"
  export RANLIB="$cfg_target_canonical-ranlib"

  ./configure                                \
    --host="${cfg_target_canonical}"         \
    --build="${cfg_host_canonical}"          \
    --prefix="${cfg_dir_toolchain_sysroot}/usr"
}

build()
{
  cd ../Python-$version

  echo "Build is in $(pwd)"
  
  $cmd_make  \
    HOSTPYTHON="../Python-$version/hostpython" \
    HOSTPGEN="../Python-$version/Parser/hostpgen" \
    BLDSHARED="$cmd_target_gcc -shared" \
    CROSS_COMPILE="$cfg_target_canonical-" \
    CROSS_COMPILE_TARGET="yes" \
    HOSTARCH="${cfg_target_canonical}" \
    BUILDARCH="${cfg_host_canonical}"
}

host_install()
{
  cd ../Python-$version

  echo "Target install is in $(pwd)"
  $cmd_make install \
    HOSTPYTHON=./hostpython \
    BLDSHARED="$cmd_target_cc -shared" \
    CROSS_COMPILE="$cfg_target_canonical-" \
    CROSS_COMPILE_TARGET=yes
#    prefix="${cfg_dir_toolchain_sysroot}/usr"
}

target_install()
{
  $cmd_cp "${cfg_dir_toolchain_sysroot}/usr/lib/"python* "${cfg_dir_rootfs}/usr/lib"
  $cmd_cp "${cfg_dir_toolchain_sysroot}/usr/bin/"python* "${cfg_dir_rootfs}/usr/bin"
  # Python needs the include files because it parse it for knowing some data...
  $cmd_mkdir "${cfg_dir_rootfs}/usr/include/"
  $cmd_cp "${cfg_dir_toolchain_sysroot}/usr/include/"python* "${cfg_dir_rootfs}/usr/include/"
}

