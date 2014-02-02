source $pkg_common

configure()
{
  echo "Post unpack is in $(pwd)"
  echo "Pre-configuring by building an host python ... $(pwd) "
  cd ../Python-$version/
  ./configure
}

build()
{
  cd ../Python-$version

  $cmd_make python Parser/pgen
}

host_install()
{
  cd ../Python-$version
  mv python hostpython
  mv Parser/pgen Parser/hostpgen
  $cmd_make distclean
}

