version=\
(
    '4.6.4'
)

url=\
(
    "http://mirrors.kernel.org/gnu/gcc/gcc-$version/gcc-$version.tar.bz2"
)

md5=\
(
    'b407a3d1480c11667f293bfb1f17d1a4'
)

build_dir=$PKG_VAR

post_unpack()
{
    patches=$(ls "$cfg_package_spec_dir/patches-${version}/"*.patch)
    if [ -n "$patches" ]; then
        cd "../gcc-$version" &&  cat $patches | patch -p1
    fi
}
