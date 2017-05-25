version=\
(
  "4.5.0"
)

url=\
(
  "http://ftp.gnu.org/gnu/screen/screen-$version.tar.gz"
)

md5=\
(
  "a32105a91359afab1a4349209a028e31"
)

requires=\
(
  "ncurses/default"
)

post_unpack()
{
  patches=$(ls "$pkg_dir"/patches/*.patch)
  if [ -n "$patches" ]; then
      cat $patches | patch -p1
  fi

  autoconf
  aclocal
}

configure()
{
  ./configure \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --enable-colors256
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
  $cmd_cp  $cfg_dir_toolchain_sysroot/usr/share/screen $cfg_dir_rootfs/usr/share/
  $cmd_cp  $cfg_dir_toolchain_sysroot/usr/bin/screen-$version $cfg_dir_rootfs/usr/bin/screen
  $cmd_cp  etc/screenrc $cfg_dir_rootfs/etc/screenrc
}


