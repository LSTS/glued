source $PKG_COMMON

requires=\
(
    'eglibc/cross'
)

configure()
{
    "../eglibc-$version/localedef/configure" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --with-glibc=."./eglibc-$version/libc"
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_mkdir "$cfg_dir_toolchain_sysroot/usr/lib/locale" &&
    if [ -f "$cfg_dir_toolchain_sysroot/usr/share/i18n/charmaps/UTF-8.gz" ]; then
        gunzip -f "$cfg_dir_toolchain_sysroot/usr/share/i18n/charmaps/UTF-8.gz"
    fi &&
    if [ -f "$cfg_dir_toolchain_sysroot/usr/share/i18n/charmaps/ISO-8859-1.gz" ]; then
        gunzip -f "$cfg_dir_toolchain_sysroot/usr/share/i18n/charmaps/ISO-8859-1.gz"
    fi &&

    ./localedef -v -c -i pt_PT -f UTF-8 pt_PT.UTF-8
    ./localedef -v -c -i ru_RU -f UTF-8 ru_RU.UTF-8
    true
}

target_install()
{
    $cmd_mkdir "$cfg_dir_rootfs/usr/lib/locale" &&
    cp -v "$cfg_dir_toolchain_sysroot/usr/lib/locale/locale-archive" "$cfg_dir_rootfs/usr/lib/locale"
}
