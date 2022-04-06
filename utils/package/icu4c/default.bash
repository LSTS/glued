version=\
(
    '51.2'
)

vendor_version="$(echo $version | tr . _)"

url=\
(
    "http://download.icu-project.org/files/icu4c/$version/icu4c-${vendor_version}-src.tgz"
)

md5=\
(
    '072e501b87065f3a0ca888f1b5165709'
)

configure()
{
    # Build ICU for host.
    mkdir -p "${pkg_build_dir}/host" &&
    cd "${pkg_build_dir}/host" &&
    "${pkg_build_dir}/../icu/source/configure" \
        --prefix="${pkg_build_dir}/host-dist" \
        --with-data-packaging=static \
        --enable-static \
        --disable-shared &&
        make &&
        make install &&
        rm -rf "${pkg_build_dir}/host-dist/config" &&
        cp bin/icupkg "${pkg_build_dir}/host-dist/bin" &&
        cp -r config "${pkg_build_dir}/host-dist" &&

        # Configure for target.
        cd "${pkg_build_dir}" &&
        ../icu/source/configure \
            --prefix="${cfg_dir_toolchain_sysroot}/usr" \
            --enable-shared \
            --enable-static \
            --target=$cfg_target_canonical \
            --host=$cfg_target_canonical \
            --build=$cfg_host_canonical \
            --with-cross-build="${pkg_build_dir}/host-dist" \
            --with-data-packaging=static
}

build()
{
    $cmd_make -C "${pkg_build_dir}"
}

host_install()
{
    $cmd_make -C "${pkg_build_dir}" install
}

target_install()
{
    base="$cfg_dir_toolchain_sysroot/usr/lib"
    for f in "$base/libicu"*".so"*; do
        dst="$cfg_dir_rootfs/lib/$(basename "$f")"
        cp -v -d "$f" "$dst" &&
        $cmd_target_strip "$dst"
    done
}
