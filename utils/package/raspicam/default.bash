version=\
(
    "1.0.0"
)

url=\
(
    "http://lsts.pt/glued/raspicam-$version.zip"
)

md5=\
(
  "169e62fd17d41455a42711a2f9c54fd1"
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

requires=\
(
    'uv4l/default'
    'cmake/host'
)

configure()
{
    LINKER_ADDED_FLAGS="-Wl,-rpath,${cfg_dir_rootfs}/usr/lib"

    ${cfg_dir_toolchain}/usr/local/bin/cmake \
        -DCMAKE_SYSTEM_NAME="Linux" \
        -DCMAKE_SYSTEM_VERSION="1" \
        -DCMAKE_FIND_ROOT_PATH="${cfg_dir_toolchain_sysroot}/usr ${cfg_dir_rootfs}/usr" \
        -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
        -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
        -DCMAKE_C_COMPILER="${cmd_target_cc}" \
        -DCMAKE_CXX_COMPILER="${cmd_target_cxx}" \
        -DCMAKE_C_FLAGS="${cfg_target_gcc_flags}" \
	.
}

build()
{
    $cmd_make VERBOSE=1
}

host_install()
{
    cd build/
    $cmd_cp -r "lib/"* "$cfg_dir_toolchain_sysroot/usr/lib/"
    $cmd_cp -r "inc/"* "$cfg_dir_toolchain_sysroot/usr/include/"
}

target_install()
{
    cd build/
    $cmd_cp -r "lib/"* "$cfg_dir_rootfs/usr/lib/"
    $cmd_cp -r "bin/"* "$cfg_dir_rootfs/usr/bin/"
}
