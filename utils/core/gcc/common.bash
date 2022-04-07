version=\
(
    '5.4.0'
)

url=\
(
    "http://mirrors.kernel.org/gnu/gcc/gcc-$version/gcc-$version.tar.bz2"
)

md5=\
(
    '4c626ac2a83ef30dfb9260e6f59c2b30'
)

build_dir=$pkg_var

post_unpack()
{
    patches=$(ls "$pkg_dir/patches-${version}/"*.patch)
    if [ -n "$patches" ]; then
        cd "../gcc-$version" &&  cat $patches | patch -p1
    fi
}
