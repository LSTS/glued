version=\
(
    '1.14.4'
)

url=\
(
    "http://downloads.sourceforge.net/mpg123/mpg123-$version.tar.bz2"
)

md5=\
(
    'a72d0c60a1d7dbec7cfe966bc11672bf'
)

requires=\
(
    'alsa-lib/default'
)

# Support more processor:
configure()
{
    ./configure \
        --prefix="${cfg_dir_toolchain_sysroot}/usr" \
        --build="${cfg_host_canonical}" \
        --host="${cfg_target_canonical}" \
        --with-optimization=0 \
        --disable-lfs-alias \
        --enable-shared
}


build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}

target_install()
{
    cp -v ${cfg_dir_toolchain_sysroot}/usr/bin/mpg123* ${cfg_dir_rootfs}/usr/bin
    cp -v ${cfg_dir_toolchain_sysroot}/usr/lib/libmpg123* ${cfg_dir_rootfs}/usr/lib
}
