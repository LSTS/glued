version=\
(
    '2.3.7'
)

url=\
(
    "https://swupdate.openvpn.org/community/releases/openvpn-$version.tar.xz"
)

md5=\
(
    '5b819f7cd0b875f55f20a947224967aa'
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

requires=\
(
    'openssl/default'
    'lzo/default'
)

configure()
{
    "../openvpn-$version/configure" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --disable-plugin-auth-pam
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
    $cmd_target_strip "$cfg_dir_toolchain_sysroot/usr/sbin/openvpn" -o "$cfg_dir_rootfs/bin/openvpn"
}
