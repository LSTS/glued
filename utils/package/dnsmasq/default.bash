version=\
(
    '2.63'
)

url=\
(
    "http://www.thekelleys.org.uk/dnsmasq/dnsmasq-$version.tar.gz"
)

md5=\
(
    '43e771997615ebcd8f6c6ffa60c3e40b'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

build()
{
    $cmd_make \
        CC="$cmd_target_cc"
}

target_install()
{
    $cmd_target_strip src/dnsmasq -o "$cfg_dir_rootfs/usr/sbin/dnsmasq" &&
    tar -C "$pkg_dir/fs" -c -f - . | tar -C "$cfg_dir_rootfs" -x -v -f -
}
