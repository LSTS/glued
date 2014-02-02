source $pkg_common

requires=\
(
    'gcc/cross_stage1'
    'linux-headers/cross'
)

host_install()
{
    cat >> configparms << EOF
install-bootstrap-headers=yes
cross-compiling=yes
install_root="$cfg_dir_toolchain_sysroot"
EOF

    $cmd_make \
        install_root="$cfg_dir_toolchain_sysroot" \
        install-bootstrap-headers=yes install-headers &&
    $cmd_mkdir "$cfg_dir_toolchain_sysroot/usr/lib" &&
    $cmd_make csu/subdir_lib &&
    cp csu/crt1.o csu/crti.o csu/crtn.o "$cfg_dir_toolchain_sysroot/usr/lib" &&
    $cmd_target_cc -nostdlib -nostartfiles -shared -x c /dev/null -o "$cfg_dir_toolchain_sysroot/usr/lib/libc.so"
}
