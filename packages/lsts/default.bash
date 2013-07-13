version=\
(
    '1.0'
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

requires=\
(
    'python_host/host'
    'dnsmasq/default'
)

download()
{
    mkdir -p dnsmasq.d &&
    python "$cfg_package_spec_dir/download-peers.py" dnsmasq.d
}

target_install()
{
    tar -C "$cfg_package_spec_dir/fs" --exclude .svn -c -f - . | tar -C "$cfg_dir_rootfs" -x -v -f - &&
    tar -C dnsmasq.d --exclude .svn -c -f - . | tar -C "$cfg_dir_rootfs/etc" -x -v -f -
}
