version=\
(
    '2.37.1'
)

url=\
(
    "http://ftp.acc.umu.se/pub/gnome/sources/glib/2.37/glib-$version.tar.xz"
)

md5=\
(
    'bee51d61aa0d9b4071e997ff6c5fed5e'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'pcre/default'
    'libffi/default'
)

configure()
{
    export PKG_CONFIG_PATH="$cfg_dir_toolchain_sysroot/usr/lib/pkgconfig"
    export glib_cv_stack_grows=no
    export glib_cv_uscore=yes
    export ac_cv_func_posix_getpwuid_r=yes
    export ac_cv_func_posix_getgrgid_r=yes

    ./configure \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --enable-gtk-doc-html=no \
        --enable-xattr=no \
        --with-pcre=system \
        --with-libiconv=no \
        --disable-silent-rules
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}
