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
    'ftjam/rpi4-host'
    'apache-ant/rpi4-host'
    'libantlr3c/rpi4'
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
    eval "apt-get update; apt install -y openjdk-8-jdk"
    mkdir $cfg_dir_builds/$pkg/toolchain
    mkdir $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical
    mkdir $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot
    mkdir $cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot/usr
    export cfg_dir_output_toolchain_sysroot=$cfg_dir_builds/$pkg/toolchain/$cfg_target_canonical/sysroot

    OLD_PATH="$PATH"
    export PATH="$pkg_dir/compat:$PATH"
    export PLASMA_HOME="$cfg_dir_builds/$pkg/europa-$version"
    export EUROPA_HOME="$cfg_dir_output_toolchain_sysroot/usr"

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
    cp -av dist/europa/{bin,lib,include} "$cfg_dir_output_toolchain_sysroot/usr"
}

target_install()
{
    mkdir $cfg_dir_builds/$pkg/rootfs
    mkdir $cfg_dir_builds/$pkg/rootfs/usr
    mkdir $cfg_dir_builds/$pkg/rootfs/usr/lib
    mkdir $cfg_dir_builds/$pkg/rootfs/usr/share
    mkdir $cfg_dir_builds/$pkg/rootfs/usr/share/europa
    mkdir $cfg_dir_builds/$pkg/rootfs/usr/share/europa/config
    mkdir $cfg_dir_builds/$pkg/rootfs/usr/share/europa/include
    export cfg_dir_output_rootfs=$cfg_dir_builds/$pkg/rootfs

    # Install configuration files.
    $cmd_mkdir "$cfg_dir_output_rootfs/usr/share/europa" &&
    $cmd_mkdir "$cfg_dir_output_rootfs/usr/share/europa/config" &&
    $cmd_mkdir "$cfg_dir_output_rootfs/usr/share/europa/include" &&
    cp -av "../europa-$version/dist/europa/config/"* "$cfg_dir_output_rootfs/usr/share/europa/config" &&
    cp -av "../europa-$version/dist/europa/include/"* "$cfg_dir_output_rootfs/usr/share/europa/include" &&

    # Install libraries.
    for f in "../europa-$version/dist/europa/lib/"*.so; do
        dst="$cfg_dir_output_rootfs/usr/lib/$(basename "$f")"
        cp -v -d "$f" "$dst" &&
        $cmd_target_strip "$dst"
    done

   tar -czf ../europa-v$version.tar.gz ../rootfs ../toolchain
}
