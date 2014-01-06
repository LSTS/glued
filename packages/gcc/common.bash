version=\
(
    '4.8.2'
)

url=\
(
    "http://mirrors.kernel.org/gnu/gcc/gcc-$version/gcc-$version.tar.bz2"
)

md5=\
(
    'a3d7d63b9cb6b6ea049469a0c4a43c9d'
)

build_dir=$PKG_VAR

post_unpack()
{
    patches=$(ls "$cfg_package_spec_dir/patches-${version}/"*.patch)
    if [ -n "$patches" ]; then
        cd "../gcc-$version" &&  cat $patches | patch -p1
    fi
}
