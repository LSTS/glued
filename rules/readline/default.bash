version=\
(
    '6.2'
)

revision=\
(
    '1'
)

url=\
(
    "ftp://ftp.gnu.org/gnu/readline/readline-$version.tar.gz"
)

md5=\
(
    '67948acb2ca081f23359d0256e9a271c'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

post_unpack()
{
    patches=$(ls "$cfg_package_spec_dir/patches/"*.patch)
    if [ -n "$patches" ]; then
        cat $patches | patch -p0
    fi
}

configure()
{
    "../readline-$version/configure" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical"
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
    for lib in history readline; do
        install "$cfg_dir_toolchain_sysroot/usr/lib/lib$lib.so"* "$cfg_dir_rootfs/usr/lib"
        $cmd_target_strip --strip-unneeded "$cfg_dir_rootfs/usr/lib/lib$lib.so"*
    done
}
