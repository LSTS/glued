version=\
(
    '4.9.3'
)

url=\
(
    "https://lsts.pt/glued/gcc-$version.tar.bz2"
)

md5=\
(
    '0abd6a50e1d6cf1642ae2414cc5a10b6'
)

build_dir=$pkg_var

post_unpack()
{
    patches=$(ls "$pkg_dir/patches-${version}/"*.patch)
    if [ -n "$patches" ]; then
        cd "../gcc-$version" &&  cat $patches | patch -p1
    fi
}
