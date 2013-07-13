version=\
(
    '2.24.18'
)

url=\
(
    "http://ftp.gnome.org/pub/gnome/sources/gtk+/2.24/gtk+-$version.tar.xz"
)

md5=\
(
    '4309379acdcd8abfb72ea89bce3e7746'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'glib/default'
    'pango/default'
    'atk/default'
    'gdk-pixbuf/default'
)

configure()
{
    export PKG_CONFIG_PATH="$cfg_dir_toolchain_sysroot/usr/lib/pkgconfig"
    export glib_cv_stack_grows=no
    export glib_cv_uscore=yes
    export ac_cv_func_posix_getpwuid_r=yes
    export ac_cv_func_posix_getgrgid_r=yes

    "../gtk+-$version/configure" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --enable-gtk-doc-html=no \
        --enable-xattr=no \
        --with-pcre=system \
        --with-libiconv=no \
        --disable-silent-rules \
        --disable-cups
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}
