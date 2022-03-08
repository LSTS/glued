source $pkg_common

requires=\
(
    'gcc/cross_stage2-lctr-rpi4'
)

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install_root="$cfg_dir_toolchain_sysroot" install
}

target_install()
{
    $cmd_mkdir \
        "$cfg_dir_rootfs/sbin" \
        "$cfg_dir_rootfs/usr/lib" &&

    for f in "$cfg_dir_toolchain_sysroot/lib"/*; do
        base="$(basename $f)"
        if [ -L "$f" ]; then
            cp -vd "$f" "$cfg_dir_rootfs/usr/lib/$base"
        elif [ -f "$f" ]; then
            $cmd_target_strip -v --strip-unneeded -o "$cfg_dir_rootfs/usr/lib/$base" "$f"
        fi
    done

    $cmd_target_strip -v --strip-unneeded "elf/ldconfig" \
        -o "$cfg_dir_rootfs/sbin/ldconfig" &&
    tar -C "$pkg_dir/fs" --exclude .svn -c -f - . | tar -C "$cfg_dir_rootfs" -x -v -f -
}
