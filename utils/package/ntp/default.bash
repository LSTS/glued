version=\
(
    '4.2.6p5'
)

url=\
(
    "ftp://gentoo.mirrors.ovh.net/gentoo-distfiles/distfiles/ntp-$version.tar.gz"
)

md5=\
(
    '00df80a84ec9528fcfb09498075525bc'
)

configure()
{
    mkdir -p $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot/usr
    export cfg_dir_output_toolchain=$cfg_dir_builds/$pkg/toolchain

    "../ntp-$version/configure" \
        --prefix="${cfg_dir_output_toolchain}/usr" \
        --target=$cfg_target_canonical \
        --host=$cfg_target_canonical \
        --build=$cfg_host_canonical \
        --disable-all-clocks \
        --disable-parse-clocks \
        --enable-NMEA \
        --enable-LOCAL-CLOCK \
        --without-net-snmp-config
}

build()
{
    $cmd_make
}

target_install()
{
    mkdir -p $cfg_dir_builds/$pkg/rootfs/usr/bin
    export cfg_dir_output_rootfs=$cfg_dir_builds/$pkg/rootfs

    $cmd_target_strip ntpd/ntpd -o $cfg_dir_output_rootfs/usr/bin/ntpd &&
    $cmd_target_strip ntpdate/ntpdate -o $cfg_dir_output_rootfs/usr/bin/ntpdate &&
    $cmd_target_strip ntpq/ntpq -o $cfg_dir_output_rootfs/usr/bin/ntpq &&
    tar -C "$pkg_dir/fs" --exclude .svn -c -f - . | tar -C "$cfg_dir_output_rootfs" -x -v -f -

    tar -czf ../ntp-v$version.tar.gz ../rootfs
}
