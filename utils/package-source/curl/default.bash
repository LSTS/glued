version=\
(
  7.28.0
)

url=\
(
    http://curl.haxx.se/download/curl-${version}.tar.bz2
)

md5=\
(
  7fc605a13d1420b16bd03a2a6b5d7e8e
)

configure()
{
  export CC="$cfg_target_canonical-gcc"
  export CXX="$cfg_target_canonical-g++"
  export AR="$cfg_target_canonical-ar"
  export RANLIB="$cfg_target_canonical-ranlib"

#  cd ../curl-$version/
  ./configure \
    --host="${cfg_target_canonical}" \
    --build="${cfg_host_canonical}" \
    --prefix="${cfg_dir_toolchain_sysroot}/usr"
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
    for f in "${cfg_dir_toolchain_sysroot}/usr/lib/"libcurl*so*; do
        echo "Doing $f"
        $cmd_target_strip "$f" -o "${cfg_dir_rootfs}/lib/$(basename "$f")"
    done
}
