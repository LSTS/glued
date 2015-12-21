version=\
(
    '4.9.3'
)

url=\
(
    "http://mirrors.kernel.org/gnu/gcc/gcc-$version/gcc-$version.tar.bz2"
)

md5=\
(
    '6f831b4d251872736e8e9cc09746f327'
)

build_dir=$pkg_var

post_unpack()
{
    patches=$(ls "$pkg_dir/patches-${version}/"*.patch)
    if [ -n "$patches" ]; then
        cd "../gcc-$version" &&  cat $patches | patch -p1
    fi
}
