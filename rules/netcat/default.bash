version=\
(
    "110"
)

url=\
(
    "https://kent.dl.sourceforge.net/project/nc$version/unix%20netcat%201.10%20by%20_Hobbit_/nc$version.tgz"
)

md5=\
(
    "402632f2fe01c169ff19a0ad6e9d608c"
)

post_unpack()
{
  cd "../netcat-$version"
  mv ../data .
  mv ../generic.h .
  mv ../Makefile .
  mv ../netcat.blurb .
  mv ../netcat.c .
  mv ../README .
  mv ../Changelog .
  mv ../scripts .
  mv ../stupidh .

  patches=$(ls "$pkg_dir"/patches/*.patch)
  if [ -n "$patches" ]; then
      cat $patches | patch -p1
  fi
}

build()
{
  make nc CC="$cmd_target_cc"
}

host_install()
{
  $cmd_cp nc "${cfg_dir_toolchain_sysroot}/usr/bin/"
  $cmd_mkdir "${cfg_dir_toolchain_sysroot}/usr/share/bin/"
  $cmd_cp scripts/* "${cfg_dir_toolchain_sysroot}/usr/share/bin/"
}

target_install()
{
  $cmd_target_strip nc -o "$cfg_dir_rootfs/usr/bin/nc"
  $cmd_mkdir ${cfg_dir_rootfs}/usr/share/bin/
  $cmd_cp scripts/* "${cfg_dir_rootfs}/usr/share/bin/"
}
