version=\
(
    '2.6-6693'
)

url=\
(
    "http://www.lsts.pt/glued/europa-$version.tar.bz2"
)

md5=\
(
    'da9ac50c01696a822e47c6abbc722579'
)

maintainer=\
(
    'Jose Pinto <zepinto@fe.up.pt>'
)

requires=\
(
    'ftjam/host'
    'apache-ant/host'
    'libantlr3c/default'
)

post_unpack()
{
    patches=$(ls "$pkg_dir"/patches-$version/*.patch)

    if [ -n "$patches" ]; then
        cat $patches | patch -p1
    fi
}

build()
{
    OLD_PATH="$PATH"
    export PATH="$pkg_dir/compat:$PATH"
    export PLASMA_HOME="$PWD/../europa-$version"
    export EUROPA_HOME="$cfg_dir_toolchain_sysroot/usr"

    cd $PLASMA_HOME/src/PLASMA &&

    jam -dx \
        -sLOGGER_TYPE= \
        -sVARIANTS=OPTIMIZED \
        -sLIBRARIES=SHARED \
        -sPLATFORM_FLAGS="-I$cfg_dir_toolchain_sysroot/usr/include" \
        -sLINKLIBS="-Wl,-L$cfg_dir_toolchain_sysroot/usr/lib" \
        -j1 \
        build &&

    cd $PLASMA_HOME &&

    ant \
        -Djam.args="-dx" \
        -Djam.num.cores="$cfg_host_cores" \
        -Djam.variant=OPTIMIZED \
        -Djam.libraries=SHARED dist \
        -Dantlr.lib="$cfg_dir_toolchain_sysroot/usr/lib" \
        -Dantlr.include="$cfg_dir_toolchain_sysroot/usr/include" \
        dist &&

    rm dist/europa/lib/libantlr3c.* &&

    export PATH="$OLD_PATH"
}

host_install()
{
    cp -av dist/europa/{bin,lib,include} "$cfg_dir_toolchain_sysroot/usr"
}

target_install()
{
    # Install configuration files.
    $cmd_mkdir "$cfg_dir_rootfs/usr/share/europa" &&
    $cmd_mkdir "$cfg_dir_rootfs/usr/share/europa/config" &&
    $cmd_mkdir "$cfg_dir_rootfs/usr/share/europa/include" &&
    cp -av "../europa-$version/dist/europa/config/"* "$cfg_dir_rootfs/usr/share/europa/config" &&
    cp -av "../europa-$version/dist/europa/include/"* "$cfg_dir_rootfs/usr/share/europa/include" &&

    # Install libraries.
    for f in "../europa-$version/dist/europa/lib/"*.so; do
        dst="$cfg_dir_rootfs/usr/lib/$(basename "$f")"
        cp -v -d "$f" "$dst" &&
        $cmd_target_strip "$dst"
    done
}
