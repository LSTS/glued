version=\
(
    '2.4.5'
)

url=\
(
    "http://ftp.samba.org/pub/ppp/ppp-$version.tar.gz"
)

md5=\
(
    '4621bc56167b6953ec4071043fe0ec57'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'libpcap/default'
)

post_unpack()
{
    for patch in "$pkg_dir"/patches/*; do
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
    mkdir -p $cfg_dir_builds/$pkg/rootfs/usr/sbin
    export cfg_dir_output_rootfs=$cfg_dir_builds/$pkg/rootfs

    $cmd_target_strip pppd/pppd -o $cfg_dir_output_rootfs/usr/sbin/pppd &&
    $cmd_target_strip chat/chat -o $cfg_dir_output_rootfs/usr/sbin/chat

    tar -czf ../ppp-v$version.tar.gz ../rootfs
}
