source $pkg_common

build()
{
    CC="$cmd_host_cc" \
        $cmd_make \
        PREFIX="$cfg_dir_toolchain"
}

host_install()
{
    CC="$cmd_host_cc" \
        $cmd_make \
        PREFIX="$cfg_dir_toolchain" install
}
