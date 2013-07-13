version=\
(
    '3.2.33'
)

url=\
(
    "http://www.kernel.org/pub/linux/kernel/v3.0/linux-$version.tar.bz2"
)

md5=\
(
    '486521c7b00a92fc99e122b84ae9f089'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
    $cmd_make -C "../linux-$version" \
        ARCH="$cfg_target_linux" \
        distclean mrproper
}

host_install()
{
    $cmd_make -C "../linux-$version" \
        ARCH="$cfg_target_linux" \
        INSTALL_HDR_PATH="$cfg_dir_toolchain_sysroot/usr" \
        headers_install
}
