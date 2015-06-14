version=\
(
    "1.55.0"
)

vendor_version="$(echo $version | tr . _)"

url=\
(
    "http://downloads.sourceforge.net/project/boost/boost/$version/boost_$vendor_version.tar.bz2"
)

maintainer=\
(
    'Jose Pinto <zepinto@fe.up.pt>'
)

md5=\
(
    "d6eef4b4cacb2183f2bf265a5a03a354"
)

requires=\
(
    'bzip2/default'
)

post_unpack()
{
    patches=$(ls "$pkg_dir/patches-${version}/"*.patch)
    if [ -n "$patches" ]; then
        cd "../boost_$vendor_version" &&  cat $patches | patch -p1
    fi
}

configure()
{
    cd "../boost_$vendor_version" &&
    ./bootstrap.sh \
        --with-icu="$cfg_dir_toolchain_sysroot/usr"

    GXX_VER=$(${cmd_target_cxx} -dumpversion)
    echo "using gcc : ${GXX_VER}  : ${cmd_target_cxx} : <cxxflags>\"-pipe -Os  -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 ${cfg_target_gcc_flags} \" <linkflags>\"\" ;" > user-config.jam
    echo "" >> user-config.jam
}

build()
{
    cd "../boost_$vendor_version" &&
    ./bjam -d+2 \
	toolset=gcc \
	variant=release \
	link=shared \
	threading=multi \
	runtime-link=shared \
        -sICU_PATH="$cfg_dir_toolchain_sysroot/usr" \
	--user-config=user-config.jam \
	--prefix="${cfg_dir_toolchain_sysroot}/usr" \
	--without-python \
	--layout=tagged
}


host_install()
{
    cd "../boost_$vendor_version" &&
    ./bjam -d+2 \
	toolset=gcc \
	variant=release \
	link=shared \
	threading=multi \
	runtime-link=shared \
        -sICU_PATH="$cfg_dir_toolchain_sysroot/usr" \
	--user-config=user-config.jam \
	--prefix="${cfg_dir_toolchain_sysroot}/usr" \
	--without-python \
        --layout=tagged \
        install

    mkdir -p "${cfg_dir_toolchain_sysroot}/usr/share"
    cp -rvd "../boost_$vendor_version/boost" \
	"${cfg_dir_toolchain_sysroot}/usr/share"
}

target_install()
{
    base="$cfg_dir_toolchain_sysroot/usr/lib"
    for f in "$base/libboost_"*.so*; do
        dst="$cfg_dir_rootfs/lib/$(basename "$f")"
        cp -v -d "$f" "$dst" &&
        $cmd_target_strip "$dst"
    done
}
