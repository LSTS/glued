version=\
(
    "4.5.1"
)

url=\
(
    "https://github.com/opencv/opencv/archive/$version.zip"
)

md5=\
(
    'cc13d83c3bf989b0487bb3798375ee08'
)

requires=\
(
    'cmake/host-v3.5.x'
    'ffmpeg/default'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

configure()
{
    LINKER_ADDED_FLAGS="-Wl,-rpath,${cfg_dir_rootfs}/usr/lib"
    mkdir -p ../build
    cd ../build
    export PKG_CONFIG_LIBDIR=$PKG_CONFIG_LIBDIR:"$cfg_dir_rootfs"
    ${cfg_dir_toolchain}/usr/local/bin/cmake \
        -DCMAKE_SYSTEM_NAME="Linux" \
        -DCMAKE_SYSTEM_PROCESSOR="$cfg_architecture" \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_FIND_ROOT_PATH="${cfg_dir_toolchain_sysroot}/usr ${cfg_dir_rootfs}/usr" \
        -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
        -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
        -DCMAKE_C_COMPILER="${cmd_target_cc}" \
        -DCMAKE_CXX_COMPILER="${cmd_target_cxx}" \
        -DCMAKE_C_FLAGS="${cfg_target_gcc_flags}" \
        -DCMAKE_SHARED_LINKER_FLAGS="${LINKER_ADDED_FLAGS} ${CMAKE_SHARED_LINKER_FLAGS}" \
        -DCMAKE_MODULE_LINKER_FLAGS="${LINKER_ADDED_FLAGS} ${CMAKE_MODULE_LINKER_FLAGS}" \
        -DCMAKE_EXE_LINKER_FLAGS="${LINKER_ADDED_FLAGS} ${CMAKE_EXE_LINKER_FLAGS}" \
        -DCMAKE_INSTALL_PREFIX="${cfg_dir_toolchain_sysroot}/usr" \
        -DBUILD_DOCS=OFF \
        -DBUILD_EXAMPLES=OFF \
        -DBUILD_PERF_TESTS=OFF \
        -DBUILD_SHARED_LIBS=ON \
        -DBUILD_TESTS=OFF \
        -DBUILD_WITH_DEBUG_INFO=OFF \
        -DBUILD_TBB=ON \
        -DWITH_TBB=ON \
        -DWITH_FFMPEG=ON \
        ../opencv-$version/
}

build()
{
    cd  ${pkg_build_dir}/../build &&
    $cmd_make VERBOSE=1
}

host_install()
{
    cd  ${pkg_build_dir}/../build &&
    $cmd_make install
}

target_install()
{
    cd  "${pkg_build_dir}/../build" &&
    for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libopencv*so*; do
        if [ -L "$f" ]; then
           cp -av "$f" "$cfg_dir_rootfs/usr/lib"
        else
            $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
        fi
    done
}
