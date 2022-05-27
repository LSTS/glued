version=\
(
    '2.38'
)

url=\
(
    "http://mirrors.kernel.org/gnu/binutils/binutils-$version.tar.bz2"
)

md5=\
(
    '16b418651aafd9aa9d661f76b339cfa2'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

build_dir=$pkg_var

configure()
{
    "../binutils-$version/configure" \
        --prefix="$cfg_dir_toolchain" \
        --target="$cfg_target_canonical" \
        --host="$cfg_host_canonical" \
        --build="$cfg_host_canonical" \
        --with-sysroot="$cfg_dir_toolchain_sysroot" \
        --disable-multilib \
        --disable-nls
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install-strip
}
