version=\
(
    '2.22'
)

url=\
(
    "http://ftp.gnu.org/pub/gnu/glibc/glibc-$version.tar.xz"
)

md5=\
(
    'e51e02bf552a0a1fbbdc948fb2f5e83c'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

build_dir=$pkg_var

post_unpack()
{
    patches=$(ls "$pkg_dir"/patches/*.patch)

    cd ../glibc-$version
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
        "../glibc-$version/configure" \
        $cfg_target_glibc_configure_flags \
        --prefix=/usr \
        --with-headers="$cfg_dir_toolchain_sysroot/usr/include" \
        --with-build-sysroot="$cfg_dir_toolchain_sysroot" \
        --with-sysroot="$cfg_dir_toolchain_sysroot" \
        --build="$cfg_host_canonical" \
        --host="$cfg_target_canonical" \
        --disable-multilib \
        --disable-profile \
        --without-gd \
        --without-cvs \
        --enable-add-ons \
        --with-tls \
        --enable-kernel=2.6.32 \
        --disable-nls \
        --enable-static-nss \
        --disable-werror \
        --enable-obsolete-rpc \
        --enable-bind-now
}
