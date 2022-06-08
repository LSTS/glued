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
    mkdir -p $cfg_dir_builds/$pkg/rootfs/usr/sbin/
    export cfg_dir_output_rootfs=$cfg_dir_builds/$pkg/rootfs

    $cmd_target_strip src/dnsmasq -o "$cfg_dir_output_rootfs/usr/sbin/dnsmasq" &&
    tar -C "$pkg_dir/fs" -c -f - . | tar -C "$cfg_dir_output_rootfs" -x -v -f -

    tar -czf ../dnsmasq-v$version.tar.gz ../rootfs
}
