version=\
(
    "1.05"
)

url=\
(
    "http://sourceforge.net/projects/sshpass/files/sshpass/${version}/sshpass-${version}.tar.gz"
)

md5=\
(
    "c52d65fdee0712af6f77eb2b60974ac7"
)

configure()
{
    export ac_cv_func_malloc_0_nonnull=yes
    ./configure \
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
    $cmd_target_strip "$cfg_dir_toolchain_sysroot/usr/bin/sshpass" -o "$cfg_dir_rootfs/bin/sshpass"
}
