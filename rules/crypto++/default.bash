version=\
(
    "5.6.2"
)

vendor_version=$(echo $version | sed 's/\.//g')

url=\
(
    "http://downloads.sourceforge.net/project/cryptopp/cryptopp/$version/cryptopp$vendor_version.zip"
)

md5=\
(
    "7ed022585698df48e65ce9218f6c6a67"
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

post_unpack()
{
    cd ..

    sed "40s/^/#/" GNUmakefile > Makefile
    sed -i '4s/^# //' Makefile
    sed -i "147s/^/#/" Makefile
    sed -i "s,\-march=native,${cfg_target_gcc_flags},g" Makefile
    mv GNUmakefile GNUmakefile.orig
}

build()
{
    $cmd_make \
	LD="$cmd_target_ld" \
	CC="$cmd_target_cc" \
	CXX="$cmd_target_cxx" \
	AR="$cmd_target_ar" \
	RANLIB="$cmd_target_ranlib" \
        -C .. \
	libcryptopp.a \
	libcryptopp.so
}

host_install()
{
    $cmd_make \
	LD="$cmd_target_ld" \
	CC="$cmd_target_cc" \
	CXX="$cmd_target_cxx" \
	AR="$cmd_target_ar" \
	RANLIB="$cmd_target_ranlib" \
        PREFIX="$cfg_dir_toolchain_sysroot/usr" \
        -C .. \
        install &&
    ln -vfs cryptopp "$cfg_dir_toolchain_sysroot/usr/include/crypto++" &&
    ln -vfs libcryptopp.so "$cfg_dir_toolchain_sysroot/usr/lib/libcrypto++.so"
}

target_install()
{
  # Libs: 
  for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libcrypto*.so*; do
    if [ -L "$f" ]; then
      $cmd_cp "$f" "$cfg_dir_rootfs/usr/lib"
    else
      $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
    fi
  done
}
