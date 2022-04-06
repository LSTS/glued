version=\
(
    '2.0.3'
)

url=\
(
    "http://horms.net/projects/kexec/kexec-tools/kexec-tools-$version.tar.bz2"
)

md5=\
(
    'b3ced2097ce3981abba38ceedc84f939'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
    "../kexec-tools-$version/configure" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --prefix="$cfg_dir_rootfs"
}

build()
{
    $cmd_make
}

target_install()
{
    $cmd_target_strip \
        "build/sbin/kexec" \
        -o "$cfg_dir_rootfs/sbin/kexec"
}
