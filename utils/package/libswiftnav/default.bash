version=\
(
    '0.11'
)

url=\
(
    "https://github.com/swift-nav/libswiftnav/archive/v$version.tar.gz"
)

md5=\
(
    '54e4d1bf00f116147f28cb92520e7e7d'
)

maintainer=\
(
    'Kristian Klausen <kristian.klausen@itk.ntnu.no>'
)

requires=\
(
    'cmake/host'
)

post_unpack()
{
    patches=$(ls "$pkg_dir/patches/$version/"*.patch\
	"$cfg_dir_system/patches/libswiftnav/"*.patch 2>/dev/null)
    if [ -n "$patches" ]; then
        cat $patches | patch -p1
    fi
}

configure()
{


    mkdir -p ../build &&
    cd ../build
    echo "$cmd_target_cc" 
    ${cfg_dir_toolchain}/usr/local/bin/cmake \
        -DCROSS="$cmd_target_cc" \
	    -DCMAKE_BUILD_TYPE=Release \
	    -DCMAKE_C_COMPILER="${cmd_target_cc}"                         \
        -DCMAKE_CXX_COMPILER="${cmd_target_cxx}"                      \
        -DCMAKE_FIND_ROOT_PATH="${cfg_dir_toolchain_sysroot}/usr" \
        -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
        -DCMAKE_INSTALL_PREFIX="$cfg_dir_toolchain_sysroot/usr" \
        -DCMAKE_C_FLAGS="${cfg_target_gcc_flags} -fPIC" \
        -DCMAKE_SYSTEM_NAME="Linux" \
        -DCMAKE_SYSTEM_PROCESSOR="$cfg_architecture" \
        "../libswiftnav-$version"

}

build()
{
    cd  ${pkg_build_dir}/../build &&
    $cmd_make
}

host_install()
{
    cd  ${pkg_build_dir}/../build &&
    $cmd_make install
}

target_install()
{
    for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libswiftnav*so; do
        if [ -L "$f" ]; then
            cp -vd "$f" "$cfg_dir_rootfs/lib"
        else
            $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/lib/$(basename "$f")"
        fi
    done
}
