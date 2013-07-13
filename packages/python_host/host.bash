source $PKG_COMMON

configure()
{
    ../Python-$version/configure \
        --prefix="${cfg_dir_toolchain}"
}

build()
{
   # Parallel build not supported
   $cmd_make_single clean
   $cmd_make_single
}

host_install()
{
   # Parallel build not supported
   $cmd_make_single install
}
