version=\
(
    '2.25'
)

url=\
(
    "http://mirrors.kernel.org/gnu/binutils/binutils-$version.tar.bz2"
)

md5=\
(
    'd9f3303f802a5b6b0bb73a335ab89d66'
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
