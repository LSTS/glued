version=\
(
    "2.8.0"
)

vendor_version="$(echo $version | tr . _)"

url=\
(
    "http://mirrors.fe.up.pt/pub/apache/xerces/c/2/sources/xerces-c-src_$vendor_version.tar.gz"
)

md5=\
(
    "5daf514b73f3e0de9e3fce704387c0d2"
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

post_unpack()
{
    patches=$(ls "$pkg_dir"/patches/*.patch)

    if [ -n "$patches" ]; then
        cd ../xerces-c-src_$vendor_version &&
        cat $patches | patch -p1
    fi
}

configure()
{
    export LDFLAGS="-L$cfg_dir_toolchain_sysroot/usr/lib"
    export XERCESCROOT=$PWD/../xerces-c-src_$vendor_version
    cd $XERCESCROOT/src/xercesc &&
    ./runConfigure -plinux \
        -P "$cfg_dir_toolchain_sysroot/usr" \
        -nfileonly \
        -tnative \
        -rpthread \
        -c"$cfg_target_canonical"-gcc \
        -x"$cfg_target_canonical"-g++ \
        -C "--host=$cfg_target_canonical"
}

build()
{
    export XERCESCROOT=$PWD/../xerces-c-src_$vendor_version

    $cmd_make -j1 \
        VERBOSE=1 \
        XERCESCROOT="$PWD/../xerces-c-src_$vendor_version" \
        -C "$XERCESCROOT/src/xercesc"
}

host_install()
{
    export XERCESCROOT=$PWD/../xerces-c-src_$vendor_version

    $cmd_make -j1 \
        VERBOSE=1 \
        XERCESCROOT="$PWD/../xerces-c-src_$vendor_version" \
        -C "$XERCESCROOT/src/xercesc" install
}

target_install()
{
    cp -a "$cfg_dir_toolchain_sysroot/usr/lib/libxerces-"* $cfg_dir_rootfs/lib &&
    for f in $cfg_dir_rootfs/lib/libxerces-*; do
        $cmd_target_strip "$f"
    done
}
