version=\
(
    2.0.0
)

url=\
(
    "http://garr.dl.sourceforge.net/project/opencvlibrary/opencv-unix/2.0/OpenCV-$version.tar.bz2"
)

md5=\
(
    'ed27520514baacc5edad7b06ad24130e'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
    "../OpenCV-$version/configure" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --without-gtk \
        --without-python \
        --without-swig \
        --disable-sse \
        --disable-apps
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}

target_install()
{
    for f in $cfg_dir_toolchain_sysroot/usr/lib/{libcv.*so*,libcvaux.so*,libcxcore.so*,libhighgui.so*,libml.so*}; do
        dst="$cfg_dir_rootfs/lib/$(basename $f)"
        if [ -f "$f" ]; then
            $cmd_target_strip "$f" -o "$dst"
        else
            cp -a "$f" -o "$dst"
        fi
    done
}
