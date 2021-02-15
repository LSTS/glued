version=\
(
    "3.4.1"
)

url=\
(
    "http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/$version/opencv-$version.zip"
)

md5=\
(
    '8464ce888f4c283895626950bada1e44'
)

requires=\
(
    'cmake/host'
    'ffmpeg/default'
)

maintainer=\
(
    'Renato Caldas <rmsc@fe.up.pt>'
)

configure()
{
    LINKER_ADDED_FLAGS="-Wl,-rpath,${cfg_dir_rootfs}/usr/lib"

    mkdir -p ../build
    cd ../build
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
