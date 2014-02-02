version=\
(
    '4.2.6p5'
)

url=\
(
    "ftp://mirror.ovh.net/gentoo-distfiles/distfiles/ntp-$version.tar.gz"
)

md5=\
(
    '00df80a84ec9528fcfb09498075525bc'
)

configure()
{
    "../ntp-$version/configure" \
        --prefix="/" \
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
    $cmd_target_strip ntpd/ntpd -o $cfg_dir_rootfs/usr/bin/ntpd &&
    $cmd_target_strip ntpdate/ntpdate -o $cfg_dir_rootfs/usr/bin/ntpdate &&
    $cmd_target_strip ntpq/ntpq -o $cfg_dir_rootfs/usr/bin/ntpq &&
    tar -C "$cfg_package_spec_dir/fs" --exclude .svn -c -f - . | tar -C "$cfg_dir_rootfs" -x -v -f -
}
