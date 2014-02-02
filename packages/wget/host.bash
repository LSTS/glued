source $pkg_common

configure()
{
  ./configure \
    --prefix="$cfg_dir_toolchain"
}

build()
{
  $cmd_make
}

host_install()
{
  $cmd_make install
}

