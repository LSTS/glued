version=\
(
    '5.15.40'
)

url=\
(
    "https://www.kernel.org/pub/linux/kernel/v5.x/linux-$version.tar.xz"
)

md5=\
(
    'ed4f84ea81ab519aeccced9f30603f02'
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
