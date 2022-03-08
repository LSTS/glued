version=\
(
    '4.6.1'
)

url=\
(
    "http://www.tcpdump.org/release/tcpdump-$version.tar.gz"
)

md5=\
(
    'dab267ec30216a069747d10314079ec7'
)

requires=\
(
    'libpcap/default'
)

configure()
{
    echo 'ac_cv_linux_vers=${ac_cv_linux_vers=2}' > config.cache
    "../tcpdump-$version/configure" -C \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --disable-static \
        --enable-shared \
        --target=$cfg_target_canonical \
        --host=$cfg_target_canonical \
        --build=$cfg_host_canonical \
        --includedir="$cfg_dir_toolchain_sysroot/usr/include" \
        --libdir="$cfg_dir_toolchain_sysroot/usr/lib" \
        --disable-ipv6
}

build()
{
    # On some system the host system lib are indicated so we remove it.
    sed -i "s,\-I/usr/include,,g" Makefile

    $cmd_make
}

host_install()
{
    $cmd_make install
}

target_install()
{
    $cmd_target_strip tcpdump -o "$cfg_dir_rootfs/usr/bin/tcpdump"
}
