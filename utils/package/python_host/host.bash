source $pkg_common

configure()
{
    mkdir -p $cfg_dir_builds/$pkg/toolchain
    export cfg_dir_output_toolchain=$cfg_dir_builds/$pkg/toolchain
    ../Python-$version/configure \
        --prefix="${cfg_dir_output_toolchain}"
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
   tar -czf ../python-v$version-host.tar.gz ../toolchain
}
