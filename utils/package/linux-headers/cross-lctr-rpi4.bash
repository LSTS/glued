version=\
(
    '4.19.163'
)

url=\
(
    "https://www.kernel.org/pub/linux/kernel/v4.x/linux-$version.tar.xz"
)

md5=\
(
    '96695ed3c7832f1eade2d460070a8036'
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
