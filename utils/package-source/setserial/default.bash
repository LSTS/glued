version=\
(
    '2.17'
)

url=\
(
    "http://downloads.sourceforge.net/setserial/setserial-$version.tar.gz"
)

md5=\
(
    'c4867d72c41564318e0107745eb7a0f2'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
    cd ../setserial-$version/ && autoreconf &&
    ../setserial-$version/configure \
        --prefix="$cfg_dir_rootfs/usr" \
        --target=$cfg_target_canonical \
        --host=$cfg_target_canonical \
        --build=$cfg_host_canonical
}

build()
{
    $cmd_make
}

target_install()
{
    $cmd_target_strip setserial -o $cfg_dir_rootfs/usr/bin/setserial
    cp "$pkg_dir"/services/setserial "$cfg_dir_rootfs/etc/rc.d"
}
