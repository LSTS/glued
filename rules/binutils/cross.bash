version=\
(
    "2.22"
)

url=\
(
    "http://mirrors.kernel.org/gnu/binutils/binutils-$version.tar.bz2"
)

md5=\
(
    "ee0f10756c84979622b992a4a61ea3f5"
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

build_dir=$pkg_var

configure()
{
    ../binutils-$version/configure $extra_flags \
        --prefix=$cfg_dir_toolchain \
        --target=${cfg_target_canonical} \
        --host=${cfg_host_canonical} \
        --build=${cfg_host_canonical} \
        --with-sysroot=$cfg_dir_toolchain_sysroot \
        --with-mpfr=${cfg_dir_toolchain} \
        --with-gmp=${cfg_dir_toolchain} \
        --with-mpc=${cfg_dir_toolchain} \
        --disable-nls \
        --disable-werror \
        --disable-multilib
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
    rm -rf $cfg_dir_toolchain/{info,man}
}
