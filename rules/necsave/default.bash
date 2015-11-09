version=\
(
    'HEAD'
)

requires=\
(
    'jansson/default'
    'czmq/default'
    'boost/default'
    'cmake/host'
    'dune/default'
)

download()
{
    git clone "git@necsave.info:necsave/communications.git" source &&
        cd source && cd - &&
        for r in duneplatform missionplanner perception vehicleplanner; do
            git clone "git@necsave.info:necsave/$r.git" "source/src/Modules/$r"
            cd "source/src/Modules/$r" && cd -
        done
}

configure()
{
    $cmd_mkdir build && cd build
    PKG_CONFIG_PATH="$cfg_dir_toolchain_sysroot/usr/lib/pkgconfig" \
    cmake \
        -DCMAKE_INSTALL_PREFIX="$cfg_dir_toolchain_sysroot/usr/necsave" \
        -DCMAKE_CXX_COMPILER="$cmd_target_cxx" \
        -DCMAKE_C_COMPILER="$cmd_target_cc" \
        -DCMAKE_FIND_ROOT_PATH:PATH="$cfg_dir_toolchain_sysroot/usr" \
        -DDUNE_HOME="$cfg_dir_toolchain_sysroot/usr" \
        -DCMAKE_SYSTEM_NAME:STRING=Linux \
        -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE:STRING=BOTH \
        -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY:STRING=ONLY \
        -DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM:STRING=BOTH \
        ../source
}

refresh()
{
  cd ../default
  rm .build .host_install .target_install .postconfigure
  cd -
  cd source && git pull && cd - &&
  for r in duneplatform missionplanner perception vehicleplanner; do
            cd "source/src/Modules/$r" && git pull && cd -
        done
}

build()
{
    $cmd_make -C build
}

host_install()
{
    $cmd_make -C build install
}

target_install()
{
    rm -rf "$cfg_dir_rootfs/usr/necsave" &&
        $cmd_cp -r "$cfg_dir_toolchain_sysroot/usr/necsave" "$cfg_dir_rootfs/usr" &&
        ln -fs /opt/lsts/necsave/log "$cfg_dir_rootfs/usr/necsave/log"
}
