source "$pkg_common"

configure()
{
    "../libffi-$version/configure" \
        "--prefix=$cfg_dir_toolchain"
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install &&
    sed 's/Libs: /Libs: -L${libdir} /g' "$cfg_dir_toolchain/lib/pkgconfig/libffi.pc" -i
}
