version=\
(
    1.16
)

url=\
(
    http://rpm5.org/files/popt/popt-$version.tar.gz
)

md5=\
(
    3743beefa3dd6247a73f8f7a32c14c33
)

configure()
{
    "../popt-$version/configure" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical"
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}
