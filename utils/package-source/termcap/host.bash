source "$pkg_common"

configure()
{
    ./configure \
	--prefix="$cfg_dir_toolchain" \
	--enable-shared \
	--disable-nls
}

build()
{
  $cmd_make
}

host_install()
{
  $cmd_make install
}
