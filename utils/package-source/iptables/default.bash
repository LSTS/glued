version=\
(
    "1.4.14"
)

url=\
(
    "http://ftp.netfilter.org/pub/iptables/iptables-$version.tar.bz2"
)

md5=\
(
    "5ab24ad683f76689cfe7e0c73f44855d"
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

configure()
{
    ../iptables-$version/configure \
        --prefix="$cfg_dir_rootfs/usr" \
        --target=$cfg_target_canonical \
        --host=$cfg_target_canonical \
        --build=$cfg_host_canonical \
        --disable-shared \
        --enable-static
}

build()
{
    $cmd_make
}

target_install()
{
    $cmd_target_strip iptables/xtables-multi -o $cfg_dir_rootfs/usr/sbin/xtables-multi &&
    ln -fs xtables-multi $cfg_dir_rootfs/usr/sbin/iptables
    ln -fs xtables-multi $cfg_dir_rootfs/usr/sbin/iptables-save
    ln -fs xtables-multi $cfg_dir_rootfs/usr/sbin/iptables-restore
    ln -fs xtables-multi $cfg_dir_rootfs/usr/sbin/ip6tables
    ln -fs xtables-multi $cfg_dir_rootfs/usr/sbin/ip6tables-save
    ln -fs xtables-multi $cfg_dir_rootfs/usr/sbin/ip6tables-restore
}
