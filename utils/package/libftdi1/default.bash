version=\
(
    '1.2'
)

url=\
(
    "http://www.intra2net.com/en/developer/libftdi/download/libftdi1-$version.tar.bz2"
)

md5=\
(
    '89dff802d89c4c0d55d8b4665fd52d0b'
)

maintainer=\
(
    'Ricardo Martins <rasm@oceanscan-mst.com>'
)

requires=\
(
    'cmake/host'
    'libusb/default'
    'confuse/default'
)

configure()
{
    export PKG_CONFIG="${cfg_dir_toolchain}/bin/pkg-config"
    export PKG_CONFIG_PATH="$cfg_dir_toolchain_sysroot/usr/lib/pkgconfig"

    rm -rf build && mkdir build && cd build

    echo "set(CMAKE_SYSTEM_NAME Linux)" > Toolchain.cmake
    echo "set(CMAKE_C_COMPILER $cmd_target_cc)" >> Toolchain.cmake
    echo "set(CMAKE_CXX_COMPILER $cmd_target_cxx)" >> Toolchain.cmake
    echo "set(CMAKE_FIND_ROOT_PATH \"$cfg_dir_toolchain_sysroot/usr\")" >> Toolchain.cmake
    echo "set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)" >> Toolchain.cmake
    echo "set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)" >> Toolchain.cmake
    echo "set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)" >> Toolchain.cmake

    cmake \
        -DCMAKE_TOOLCHAIN_FILE=./Toolchain.cmake \
        -DCMAKE_INSTALL_PREFIX="$cfg_dir_toolchain_sysroot/usr" \
        -DPKG_CONFIG_EXECUTABLE="$PKG_CONFIG" \
        ..
}

build()
{
    cmake --build build
}

host_install()
{
    export PKG_CONFIG="${cfg_dir_toolchain}/bin/pkg-config"
    export PKG_CONFIG_PATH="$cfg_dir_toolchain_sysroot/usr/lib/pkgconfig"
    cmake --build build --target install
}

target_install()
{
    cp -a "$cfg_dir_toolchain_sysroot/usr/lib/libftdi"*.so* "$cfg_dir_rootfs/lib" &&
    $cmd_target_strip "$cfg_dir_rootfs/lib/libftdi"*.so*
}
