version=\
(
    '4.19.60'
)

url=\
(
    "https://www.kernel.org/pub/linux/kernel/v4.x/linux-$version.tar.xz"
)

md5=\
(
    '3f8dfed50f9d9ff7247b3d6da4fd35a3'
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
