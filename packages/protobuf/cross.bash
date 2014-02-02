source $pkg_common

# We need to build it once on our host system in order to create the "protoc" file used by the second step.
configure()
{
  mkdir -p $pkg_build_dir/glued_host
  ./configure --prefix=$pkg_build_dir/glued_host
}

build()
{
  $cmd_make
  $cmd_make check
}

host_install()
{
  $cmd_make install
  $cmd_make distclean
}
