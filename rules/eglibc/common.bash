version=\
(
    '2.15.17955'
)

url=\
(
    "http://www.lsts.pt/glued/eglibc-$version.tar.bz2"
)

md5=\
(
    '0694f304863e3c97562857388137a83e'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

build_dir=$pkg_var

post_unpack()
{
    ln -fs ../ports ../eglibc-$version/libc/ports

    patches=$(ls "$cfg_package_spec_dir"/patches/*.patch)

    cd ../eglibc-$version
    if [ -n "$patches" ]; then
        cat $patches | patch -p1
    fi
}

configure()
{
    export libc_cv_slibdir='/lib'
    BUILD_CC=$cmd_host_cc \
        AR="$cfg_dir_toolchain/bin/$cfg_target_canonical-ar" \
        RANLIB="$cfg_dir_toolchain/bin/$cfg_target_canonical-ranlib" \
        CC="$cfg_dir_toolchain/bin/$cfg_target_canonical-gcc" \
        CXX="$cfg_dir_toolchain/bin/$cfg_target_canonical-g++" \
        CFLAGS=$cfg_target_gcc_flags \
        "../eglibc-$version/libc/configure" \
        $cfg_target_eglibc_configure_flags \
        --prefix=/usr \
        --with-headers="$cfg_dir_toolchain_sysroot/usr/include" \
        --build="$cfg_host_canonical" \
        --host="$cfg_target_canonical" \
        --disable-profile \
        --without-gd \
        --without-cvs \
        --enable-add-ons \
        --with-tls \
        --enable-kernel=2.6.32 \
        --disable-nls
}
