version=\
(
    '4.8'
)

url=\
(
    "http://downloads.sourceforge.net/strace/4.8/strace-$version.tar.xz"
)

md5=\
(
    'c575ef43829586801f514fd91bfe7575'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
    "../strace-$version/configure" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --disable-static \
        --enable-shared
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
    $cmd_target_strip strace -o $cfg_dir_rootfs/usr/bin/strace
}
