version=\
(
    "2.4.5"
)

url=\
(
    "ftp://ftp.samba.org/pub/ppp/ppp-$version.tar.gz"
)

md5=\
(
    "4621bc56167b6953ec4071043fe0ec57"
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

requires=\
(
    'libpcap/default'
)

post_unpack()
{
    for patch in "$cfg_package_spec_dir"/patches/*; do
        patch -p1 < "$patch" || return 1
    done
}

configure()
{
    export UNAME_S='Linux'
    export UNAME_R='2.6.30'
    export UNAME_M="$cfg_target_linux"
    ./configure
}

build()
{
    $cmd_make CC=$cmd_target_cc
}

target_install()
{
    $cmd_target_strip pppd/pppd -o $cfg_dir_rootfs/usr/sbin/pppd &&
    $cmd_target_strip chat/chat -o $cfg_dir_rootfs/usr/sbin/chat
}
